import 'package:flutter/material.dart';
import 'package:phonebook/core/constants/colors.dart';
import 'package:phonebook/data/model.dart';
import 'package:phonebook/presentation/widgets/custom_textfield.dart';
import 'package:phonebook/presentation/widgets/spacing_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonebook/presentation/screens/contact_list/cubit/contact_cubit.dart';

void showAddContactDialog(BuildContext context, {Contact? contact}) {
  final nameController = TextEditingController(text: contact?.name);
  final phoneController = TextEditingController(text: contact?.phone);
  final isEditing = contact != null;

  final contactCubit = context.read<ContactCubit>();

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        title: Text(
          isEditing ? 'Edit Contact' : 'Add Contact',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.hBox,
              CustomTextField(
                controller: nameController,
                hintText: 'Enter name',
                leadingIcon: Icons.person_outline,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                noBorder: true,
                height: 1.0,
              ),
              5.hBox,
              CustomTextField(
                controller: phoneController,
                hintText: 'Enter phone number',
                keyboardType: TextInputType.phone,
                leadingIcon: Icons.phone_outlined,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                noBorder: true,
                height: 1.0,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onSurface,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: primaryclr),
            child: Text(isEditing ? 'Update' : 'Save'),
            onPressed: () {
              final name = nameController.text;
              final phone = phoneController.text;

              if (name.isNotEmpty && phone.isNotEmpty) {
                if (isEditing) {
                  final updatedContact = contact.copyWith(
                    name: name,
                    phone: phone,
                  );
                  contactCubit.updateContact(updatedContact);
                } else {
                  contactCubit.addContact(name: name, phone: phone);
                }
                Navigator.of(dialogContext).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
