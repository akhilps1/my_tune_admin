import 'package:flutter/material.dart';
import 'package:my_tune_admin/provider/uploads_page_provider/uploads_page_provider.dart';
import 'package:provider/provider.dart';

import '../../general/constants.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadsPageProvider>(
      builder: (context, state, _) => Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                state.showCategories(
                  value: true,
                  categoryId: null,
                );
              },
              icon: const Icon(
                Icons.keyboard_backspace,
                color: Colors.black,
              ),
            ),
            title: const Text(
              'Products',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            elevation: 2,
            actions: [
              IconButton(
                onPressed: () async {},
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              kSizedBoxW10
            ],
          ),
        ],
      ),
    );
  }
}
