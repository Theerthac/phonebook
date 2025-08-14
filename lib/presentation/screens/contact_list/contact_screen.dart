import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonebook/core/constants/colors.dart';
import 'package:phonebook/data/model.dart';
import 'package:phonebook/presentation/screens/contact_list/cubit/contact_cubit.dart';
import 'package:phonebook/presentation/screens/contact_list/widgets/contact_list.dart';
import 'package:phonebook/presentation/screens/contact_list/widgets/shimmer_effect.dart';
import 'package:phonebook/presentation/screens/contact_list/widgets/showdialog.dart';
import 'package:phonebook/presentation/widgets/custom_search.dart';
import 'package:phonebook/presentation/widgets/custom_text.dart';
import 'package:phonebook/presentation/widgets/spacing_extensions.dart';
import 'package:phonebook/presentation/widgets/themes/theme_cubit.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const AppText('Contacts', size: 18, weight: FontWeight.w600),
          actions: [
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, state) {
                return IconButton(
                  icon: Icon(
                    state == ThemeMode.dark
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                  ),
                  onPressed: () {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: BlocBuilder<ContactCubit, ContactState>(
            builder: (context, state) {
              return Column(
                children: [
                  20.hBox,
                  _buildFilterRow(context, state),
                  20.hBox,
                  SearchField(
                    hintText: 'Search Contact',
                    fillColor: Theme.of(context).cardColor,
                    borderColor: Colors.grey.shade300,
                    leadingIcon: Icons.search,
                    borderRadius: BorderRadius.circular(40),
                    onChanged: (query) {
                      context.read<ContactCubit>().searchContact(query);
                    },
                  ),
                  20.hBox,
                  Expanded(child: _buildContactList(context, state)),
                ],
              );
            },
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              backgroundColor: Theme.of(context).cardColor,
              onPressed: () {
                showAddContactDialog(context);
              },
              child: Icon(Icons.add, color: Theme.of(context).primaryColor),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterRow(BuildContext context, ContactState state) {
    final cubit = context.read<ContactCubit>();
    bool showAllContacts = true;
    bool showFavorites = false;
    bool showRecent = false;

    if (state is ContactListSuccess) {
      showAllContacts =
          !state.showFavoritesOnly && !state.showRecentlyAddedOnly;
      showFavorites = state.showFavoritesOnly;
      showRecent = state.showRecentlyAddedOnly;
    }

    final selectedColor = Theme.of(context).primaryColor;
    final unselectedTextColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => cubit.allContacts(),
          child: Container(
            decoration: BoxDecoration(
              color: showAllContacts ? selectedColor : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: showAllContacts ? null : Border.all(color: grey300),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: AppText(
                'All Contacts',
                size: 13,
                color: showAllContacts ? Colors.white : unselectedTextColor,
                weight: FontWeight.w400,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => cubit.favoritesFilter(),
          child: Container(
            decoration: BoxDecoration(
              color: showFavorites ? selectedColor : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: showFavorites ? null : Border.all(color: grey300),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: AppText(
                'Favorite',
                size: 13,
                color: showFavorites ? Colors.white : unselectedTextColor,
                weight: FontWeight.w400,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => cubit.recentlyAdd(),
          child: Container(
            decoration: BoxDecoration(
              color: showRecent ? selectedColor : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: showRecent ? null : Border.all(color: grey300),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: AppText(
                'Recent',
                size: 13,
                color: showRecent ? Colors.white : unselectedTextColor,
                weight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactList(BuildContext context, ContactState state) {
    if (state is ContactListLoading || state is ContactInitial) {
      return ListView.separated(
        itemCount: 8,
        itemBuilder: (context, index) => const ContactListShimmer(),
        separatorBuilder: (context, index) =>
            Divider(color: grey500, thickness: 0.5),
      );
    }

    if (state is ContactListError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
            16.hBox,
            const AppText(
              'Something Went Wrong',
              size: 16,
              weight: FontWeight.w500,
            ),
          ],
        ),
      );
    }

    if (state is ContactListSuccess) {
      if (state.contacts.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.contacts_outlined, size: 64, color: grey500),
              16.hBox,
              const AppText(
                'No contacts found',
                size: 16,
                weight: FontWeight.w500,
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () => context.read<ContactCubit>().getContacts(),
        child: ListView.separated(
          itemBuilder: (context, index) {
            final contact = state.contacts[index];
            return ContactList(
              contact: contact,
              onEdit: () => showAddContactDialog(context, contact: contact),
              onDelete: () => _showDeleteDialog(context, contact),
              onToggleFavorite: () {
                context.read<ContactCubit>().updateContact(
                  contact.copyWith(isFavorite: !contact.isFavorite),
                );
              },
            );
          },
          itemCount: state.contacts.length,
          separatorBuilder: (context, index) =>
              Divider(color: grey500, thickness: 0.5),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  void _showDeleteDialog(BuildContext context, Contact contact) {
    final cubit = context.read<ContactCubit>();
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Contact'),
          content: Text('Are you sure you want to delete ${contact.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                cubit.deleteContact(contact.id);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
