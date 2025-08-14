import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phonebook/data/model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'contact_state.dart';


class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial()) {
    getContacts();
  }
  final _supabaseClient = Supabase.instance.client;
  List<Contact> _originalContacts = [];
  String _currentSearchQuery = '';
  bool _showFavoritesOnly = false;
  bool _showRecentlyAddedOnly = false;

  Future<void> getContacts() async {
    emit(ContactListLoading());
    try {
      final response = await _supabaseClient
          .from('contacts')
          .select()
          .order('name', ascending: true);

      _originalContacts =
          (response as List).map((e) => Contact.fromJson(e)).toList();
      _applyFiltersAndSearch();
    } catch (e) {
      emit(ContactListError(message: 'Failed to fetch contacts: ${e.toString()}'));
    }
  }

  void favoritesFilter() {
    _showFavoritesOnly = !_showFavoritesOnly;
    if (_showFavoritesOnly) _showRecentlyAddedOnly = false;
    _applyFiltersAndSearch();
  }

  void recentlyAdd() {
    _showRecentlyAddedOnly = !_showRecentlyAddedOnly;
    if (_showRecentlyAddedOnly) _showFavoritesOnly = false;
    _applyFiltersAndSearch();
  }

  void allContacts() {
    _showFavoritesOnly = false;
    _showRecentlyAddedOnly = false;
    _applyFiltersAndSearch();
  }
  
  void searchContact(String query) {
    _currentSearchQuery = query.toLowerCase();
    _applyFiltersAndSearch();
  }

  void _applyFiltersAndSearch() {
    List<Contact> filteredList = List.from(_originalContacts);

    if (_showFavoritesOnly) {
      filteredList = filteredList.where((c) => c.isFavorite).toList();
    } else if (_showRecentlyAddedOnly) {
      final now = DateTime.now();
      filteredList = filteredList
          .where((c) => now.difference(c.createdAt).inHours < 24)
          .toList();
      filteredList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    if (_currentSearchQuery.isNotEmpty) {
      filteredList = filteredList.where((contact) {
        return contact.name.toLowerCase().contains(_currentSearchQuery) ||
            contact.phone.contains(_currentSearchQuery);
      }).toList();
    }

    emit(ContactListSuccess(
      contacts: filteredList,
      showFavoritesOnly: _showFavoritesOnly,
      showRecentlyAddedOnly: _showRecentlyAddedOnly,
    ));
  }


Future<void> addContact({required String name, required String phone}) async {
  final tempId = 'temp-${DateTime.now().millisecondsSinceEpoch}';
  final newContact = Contact(id: tempId, name: name, phone: phone, isFavorite: false, createdAt: DateTime.now());
  
  _originalContacts.insert(0, newContact);
  _applyFiltersAndSearch();

  try {
    final response = await _supabaseClient
        .from('contacts')
        .insert({'name': name, 'phone': phone, 'is_favorite': false}).select();
    
    final realContact = Contact.fromJson(response.first);
    final index = _originalContacts.indexWhere((c) => c.id == tempId);
    if (index != -1) _originalContacts[index] = realContact;
    
    _applyFiltersAndSearch();
  } catch (e) {
    print("DATABASE ERROR CAUGHT: $e"); 

    _originalContacts.removeWhere((c) => c.id == tempId);
    emit(ContactListError(message: "DATABASE ERROR: ${e.toString()}"));
  }
}

  Future<void> updateContact(Contact contact) async {
    final originalContactIndex = _originalContacts.indexWhere((c) => c.id == contact.id);
    if (originalContactIndex == -1) return;

    final originalContact = _originalContacts[originalContactIndex];
    
    _originalContacts[originalContactIndex] = contact;
    _applyFiltersAndSearch();

    try {
      await _supabaseClient.from('contacts').update({
        'name': contact.name,
        'phone': contact.phone,
        'is_favorite': contact.isFavorite,
      }).eq('id', contact.id);
    } catch (e) {
      _originalContacts[originalContactIndex] = originalContact;
       emit(ContactListError(message: "Database Update Failed: ${e.toString()}"));
    }
  }

  Future<void> deleteContact(String contactId) async {
    final contactToDeleteIndex = _originalContacts.indexWhere((c) => c.id == contactId);
    if(contactToDeleteIndex == -1) return;

    final contactToDelete = _originalContacts[contactToDeleteIndex];
    
    _originalContacts.removeAt(contactToDeleteIndex);
    _applyFiltersAndSearch();

    try {
      await _supabaseClient.from('contacts').delete().eq('id', contactId);
    } catch (e) {
      _originalContacts.insert(contactToDeleteIndex, contactToDelete);
      emit(ContactListError(message: "Database Delete Failed: ${e.toString()}"));
    }
  }
}

