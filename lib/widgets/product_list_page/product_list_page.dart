import 'package:flutter/material.dart';
import 'package:my_tune_admin/provider/products_page_provider/products_page_provider.dart';
import 'package:my_tune_admin/provider/uploads_page_provider/uploads_page_provider.dart';
import 'package:my_tune_admin/widgets/product_list_page/widgets/custom_popup_button.dart';
import 'package:provider/provider.dart';

import '../../general/constants.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<UploadsPageProvider, ProductPageProvider>(
      builder: (context, state, state1, _) => Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                state.showCategories(
                  value: true,
                  categoryId: null,
                  name: null,
                );
              },
              icon: const Icon(
                Icons.keyboard_backspace,
                color: Colors.black,
              ),
            ),
            title: Text(
              '${state.categoryName}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            elevation: 2,
            actions: const [
              CustomPopupButton(),
              kSizedBoxW10,
            ],
          ),
          Expanded(
              child: Container(
            child: const Column(
              children: [],
            ),
          ))
        ],
      ),
    );
  }
}
