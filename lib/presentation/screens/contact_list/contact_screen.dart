import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonebook/core/constants/colors.dart';
import 'package:phonebook/presentation/screens/contact_list/cubit/contact_cubit.dart';
import 'package:phonebook/presentation/screens/contact_list/widgets/contact_list.dart';
import 'package:phonebook/presentation/widgets/custom_search.dart';
import 'package:phonebook/presentation/widgets/custom_text.dart';
import 'package:phonebook/presentation/widgets/spacing_extensions.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        title: AppText(
          'Contacts',
          color: colorBlack,
          size: 18,
          weight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocProvider(
          create: (context) => ContactCubit(),
          child: BlocBuilder<ContactCubit, ContactState>(
            builder: (context, state) {
              return Column(
                children: [
                  20.hBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: secondbuttonclr,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: AppText(
                            'All Contacts',
                            size: 13,
                            color: colorWhite,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ),
                      AppText(
                        'Favorite',
                        size: 14,
                        color: colorBlack,
                        weight: FontWeight.w500,
                      ),
                      AppText(
                        'Recent',
                        size: 14,
                        color: colorBlack,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                  20.hBox,
                  SearchField(
                    hintText: 'Search Contact',
                    fillColor: colorWhite,
                    borderColor: grey300,
                    leadingIcon: Icons.search,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  20.hBox,
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ContactList();
                      },
                      itemCount: 5,
                      separatorBuilder: (context, index) =>
                          Divider(color: grey500, thickness: 0.5),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorWhite,
        onPressed: () {},
        child: Icon(Icons.add, color: secondbuttonclr),
      ),
    );
  }
}
