import 'package:flutter/material.dart';
import 'package:my_tune_admin/model/uploads_page_model/category_model.dart';
import 'package:my_tune_admin/provider/uploads_page_provider/uploads_page_provider.dart';
import 'package:my_tune_admin/widgets/uploads_page/widgets/edit_category_dialog_box.dart';
import 'package:provider/provider.dart';

import '../../../general/constants.dart';
import '../../../serveice/custom_popup.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

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
            onPressed: () async {
              await showDialogMeassage(
                context: context,
                category: categoryModel,
              );
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
          );
        } else {
          CustomPopup.showPopup(
            context: context,
            title: 'Do you want to delete',
            content: '',
            buttonText: 'Yes',
            onPressed: () async {
              await Provider.of<UploadsPageProvider>(
                context,
                listen: false,
              ).deleteCategory(categoryModel: categoryModel);
              // ignore: use_build_context_synchronously
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

  Future showDialogMeassage({
    required BuildContext context,
    required CategoryModel category,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            type: MaterialType.transparency,
            child: EditCategoryDialogBox(
              categoryModel: category,
            ),
          );
        });
  }
}
