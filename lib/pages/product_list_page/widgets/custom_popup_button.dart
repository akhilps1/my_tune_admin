// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:my_tune_admin/model/product_model/product_model.dart';
import 'package:my_tune_admin/pages/product_list_page/widgets/update_product_dialog_box.dart';
import 'package:my_tune_admin/provider/products_page_provider/products_page_provider.dart';
import 'package:my_tune_admin/provider/uploads_page_provider/uploads_page_provider.dart';
import 'package:provider/provider.dart';

import '../../../general/constants.dart';
import '../../../serveice/custom_popup.dart';

class CustomPopupButton extends StatelessWidget {
  const CustomPopupButton({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

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
              await showDialogMeassage(context: context);
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
              await Provider.of<ProductPageProvider>(
                context,
                listen: false,
              ).deleteProduct(productModel: product);
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
                Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
                kSizedBoxW10,
                Text('Edit'),
              ],
            ),
          ),
          const PopupMenuItem(
              value: 'Delete',
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
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
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            type: MaterialType.transparency,
            child: SingleChildScrollView(
              child: UpdateProductDialogBox(
                productModel: product,
              ),
            ),
          );
        });
  }
}
