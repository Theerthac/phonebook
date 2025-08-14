import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phonebook/data/model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial()) {
    fetchContacts();
  }
  final _supabaseClient = Supabase.instance.client;
  List<Contact> _originalContacts = [];
  bool _showFavoritesOnly = false;
  bool _showRecentlyAddedOnly = false;

  Future<void> fetchContacts() async {
    if (state is ContactInitial) {
      emit(ContactListLoading());
    }
    try {
      final response = await _supabaseClient
          .from('contacts')
          .select()
          .order('name', ascending: true);

      _originalContacts = (response as List)
          .map((e) => Contact.fromJson(e))
          .toList();
      _applyFilter();
    } on PostgrestException catch (e) {
      emit(ContactListError(message: e.message));
    } catch (e) {
      emit(
        ContactListError(message: 'Failed to fetch contacts: ${e.toString()}'),
      );
    }
  }

  void toggleFavoritesFilter() {
    _showFavoritesOnly = true;
    _showRecentlyAddedOnly = false;
    _applyFilter();
  }

  void toggleRecentlyAddedFilter() {
    _showRecentlyAddedOnly = true;
    _showFavoritesOnly = false;
    _applyFilter();
  }

  void toggleAllContactsFilter() {
    _showFavoritesOnly = false;
    _showRecentlyAddedOnly = false;
    _applyFilter();
  }

  void _applyFilter() {
    List<Contact> filteredList = List.from(_originalContacts);

    if (_showFavoritesOnly) {
      filteredList = filteredList
          .where((contact) => contact.isFavorite)
          .toList();
      filteredList.sort((a, b) => a.name.compareTo(b.name));
    } else if (_showRecentlyAddedOnly) {
      final now = DateTime.now();
      filteredList = filteredList
          .where((contact) => now.difference(contact.createdAt).inHours < 24)
          .toList();
      filteredList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else {
      filteredList.sort((a, b) => a.name.compareTo(b.name));
    }

    emit(
      ContactListSuccess(
        contacts: filteredList,
        showFavoritesOnly: _showFavoritesOnly,
        showRecentlyAddedOnly: _showRecentlyAddedOnly,
      ),
    );
  }

  Future<void> addContact({required String name, required String phone}) async {
    final oldState = state;
    try {
      final newContact = Contact(
        id: 'temp-id-${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        phone: phone,
        isFavorite: false,
        createdAt: DateTime.now(),
      );

      _originalContacts.insert(0, newContact);
      _applyFilter();

      final response = await _supabaseClient.from('contacts').insert({
        'name': name,
        'phone': phone,
      }).select();

      if (response.isNotEmpty) {
        final realContact = Contact.fromJson(response.first);
        _originalContacts.remove(newContact);
        _originalContacts.insert(0, realContact);
        _applyFilter();
      }
    } on PostgrestException catch (e) {
      if (oldState is ContactListSuccess) {
        _originalContacts.removeWhere(
          (c) => c.name == name && c.phone == phone,
        );
        emit(oldState);
      }
      emit(ContactListError(message: e.message));
    } catch (e) {
      if (oldState is ContactListSuccess) {
        _originalContacts.removeWhere(
          (c) => c.name == name && c.phone == phone,
        );
        emit(oldState);
      }
      emit(ContactListError(message: 'Failed to add contact: ${e.toString()}'));
    }
  }

  Future<void> updateContact(Contact contact) async {
    final oldState = state;
    final originalContact = _originalContacts.firstWhere(
      (c) => c.id == contact.id,
    );

    try {
      final updatedOriginals = List<Contact>.from(_originalContacts);
      final index = updatedOriginals.indexWhere((c) => c.id == contact.id);
      if (index != -1) {
        updatedOriginals[index] = contact;
        _originalContacts = updatedOriginals;
        _applyFilter();
      }

      await _supabaseClient
          .from('contacts')
          .update({
            'name': contact.name,
            'phone': contact.phone,
            'is_favorite': contact.isFavorite,
          })
          .eq('id', contact.id);
    } on PostgrestException catch (e) {
      if (oldState is ContactListSuccess) {
        final index = _originalContacts.indexWhere(
          (c) => c.id == originalContact.id,
        );
        if (index != -1) {
          _originalContacts[index] = originalContact;
        }
        _applyFilter();
      }
      emit(ContactListError(message: e.message));
    } catch (e) {
      if (oldState is ContactListSuccess) {
        final index = _originalContacts.indexWhere(
          (c) => c.id == originalContact.id,
        );
        if (index != -1) {
          _originalContacts[index] = originalContact;
        }
        _applyFilter();
      }
      emit(
        ContactListError(message: 'Failed to update contact: ${e.toString()}'),
      );
    }
  }

  Future<void> deleteContact(String contactId) async {
    final oldState = state;
    final contactToDelete = _originalContacts.firstWhere(
      (c) => c.id == contactId,
    );

    try {
      _originalContacts.removeWhere((c) => c.id == contactId);
      _applyFilter();

      await _supabaseClient.from('contacts').delete().eq('id', contactId);
    } on PostgrestException catch (e) {
      if (oldState is ContactListSuccess) {
        _originalContacts.add(contactToDelete);
        _applyFilter();
      }
      emit(ContactListError(message: e.message));
    } catch (e) {
      if (oldState is ContactListSuccess) {
        _originalContacts.add(contactToDelete);
        _applyFilter();
      }
      emit(
        ContactListError(message: 'Failed to delete contact: ${e.toString()}'),
      );
    }
  }

  Future<void> searchContacts(String query) async {
    _showFavoritesOnly = false;
    _showRecentlyAddedOnly = false;

    if (query.isEmpty) {
      _applyFilter();
      return;
    }

    final filteredContacts = _originalContacts.where((contact) {
      final lowerQuery = query.toLowerCase();
      final nameMatches = contact.name.toLowerCase().contains(lowerQuery);
      final numberMatches = contact.phone.toLowerCase().contains(lowerQuery);
      return nameMatches || numberMatches;
    }).toList();

    emit(
      ContactListSuccess(
        contacts: filteredContacts,
        showFavoritesOnly: _showFavoritesOnly,
        showRecentlyAddedOnly: _showRecentlyAddedOnly,
      ),
    );
  }
}
