part of 'contact_cubit.dart';

@immutable
sealed class ContactState {}

final class ContactInitial extends ContactState {}
class ContactListLoading extends ContactState {}

class ContactListSuccess extends ContactState {
  final List<Contact> contacts;
  final bool showFavoritesOnly;
  final bool showRecentlyAddedOnly;

  ContactListSuccess({
    required this.contacts,
    this.showFavoritesOnly = false,
    this.showRecentlyAddedOnly = false,
  });
}

class ContactListError extends ContactState {
  final String message;
  ContactListError({required this.message});
}