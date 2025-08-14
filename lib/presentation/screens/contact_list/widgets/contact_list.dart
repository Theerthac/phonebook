import 'package:flutter/material.dart';
import 'package:phonebook/core/constants/colors.dart';
import 'package:phonebook/presentation/widgets/custom_text.dart';
import 'package:phonebook/presentation/widgets/spacing_extensions.dart';
import 'package:phonebook/data/model.dart';

class ContactList extends StatelessWidget {
  final Contact contact;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleFavorite;

  const ContactList({
    super.key,
    required this.contact,
    this.onEdit,
    this.onDelete,
    this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return SizedBox(
      width: context.deviceSize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFF8AA4B9),
                child: AppText(
                  contact.name.isNotEmpty ? contact.name[0].toUpperCase() : 'U',
                  size: 18,
                  weight: FontWeight.w700,
                  color: primaryclr,
                ),
              ),
              15.wBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    contact.name,
                    color: textColor,
                    size: 14,
                    weight: FontWeight.w500,
                  ),
                  AppText(
                    contact.phone,
                    color: textColor,
                    size: 13,
                    weight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  onToggleFavorite?.call();
                },
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    contact.isFavorite
                        ? Icons.star
                        : Icons.star_border_outlined,
                    color: contact.isFavorite ? Colors.amber : grey500,
                    size: 28,
                  ),
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: textColor, size: 25),
                onSelected: (String value) {
                  print('Menu item selected: $value for ${contact.name}');
                  switch (value) {
                    case 'edit':
                      onEdit?.call();
                      break;
                    case 'delete':
                      onDelete?.call();
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 20, color: colorBlack),
                        8.wBox,
                        Text('Edit'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 20, color: Colors.red),
                        8.wBox,
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
