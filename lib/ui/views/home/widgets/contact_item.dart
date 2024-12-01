import 'package:contacts_proj/ui/common/app_colors.dart';
import 'package:contacts_proj/ui/common/app_style.dart';
import 'package:contacts_proj/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  final bool isNotSafe;
  const ContactItem({super.key, required this.contact, required this.isNotSafe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 15,
                spreadRadius: 0,
                offset: const Offset(0, 0))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: kcAccentColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  contact.displayName,
                  style: kcBodyBoldStyle.copyWith(color: kcAccentColor),
                ),
                if(isNotSafe)
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red),
                )
              ],
            ),
          ),
          verticalSpaceSmall,
          ...List.generate(
            contact.phones.length,
            (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.phones[index].number,
                    style: kcBodyStyle,
                  ),
                  if (index != contact.phones.length - 1)
                    Divider(
                      color: kcDarkGreyColor.withOpacity(0.1),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
