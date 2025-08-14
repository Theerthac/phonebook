import 'package:flutter/material.dart';
import 'package:phonebook/core/constants/colors.dart';
import 'package:phonebook/presentation/widgets/custom_text.dart';
import 'package:phonebook/presentation/widgets/spacing_extensions.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.deviceSize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF8AA4B9),
                child: AppText(
                  'T',
                  size: 20,
                  weight: FontWeight.w700,
                  color: secondbuttonclr,
                ),
              ),
              15.wBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Theertha',
                    color: colorBlack,
                    size: 15,
                    weight: FontWeight.w500,
                  ),
                  AppText(
                    '9895028574',
                    color: greyText,
                    size: 13,
                    weight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),

          Row(
            children: [
              Icon(Icons.star_border_outlined, color: grey500, size: 28),
              Icon(Icons.more_vert, color: colorBlack, size: 25),
            ],
          ),
        ],
      ),
    );
  }
}
