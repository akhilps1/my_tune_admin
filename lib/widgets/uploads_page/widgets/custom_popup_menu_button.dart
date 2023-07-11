import 'package:flutter/material.dart';

import '../../../general/constants.dart';
import '../../../serveice/custom_popup.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onSelected: (value) {
        if (value == 'Edit') {
          CustomPopup.showPopup(
            context: context,
            title: 'Do you want to edit',
            content: '',
            buttonText: 'Yes',
            onPressed: () {
              Navigator.pop(context);
            },
          );
        } else {
          CustomPopup.showPopup(
            context: context,
            title: 'Do you want to delete',
            content: '',
            buttonText: 'Yes',
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }
      },
      itemBuilder: ((context) {
        return <PopupMenuEntry>[
          const PopupMenuItem(
            value: 'Edit',
            child: Row(
              children: [
                Icon(Icons.edit),
                kSizedBoxW10,
                Text('Edit'),
              ],
            ),
          ),
          const PopupMenuItem(
              value: 'Delete',
              child: Row(
                children: [
                  Icon(Icons.delete),
                  kSizedBoxW10,
                  Text('Delete'),
                ],
              ))
        ];
      }),
    );
  }
}
