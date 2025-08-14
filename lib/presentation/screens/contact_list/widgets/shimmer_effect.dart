import 'package:flutter/material.dart';
import 'package:phonebook/presentation/widgets/spacing_extensions.dart';
import 'package:shimmer/shimmer.dart';

class ContactListShimmer extends StatelessWidget {
  const ContactListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[850]!
          : Colors.grey[300]!,
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[800]!
          : Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const CircleAvatar(radius: 28),
            15.wBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  8.hBox,
                  Container(width: double.infinity, height: 12.0, color: Colors.white),
                  8.hBox,
                  Container(width: MediaQuery.of(context).size.width * 0.4, height: 10.0, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}