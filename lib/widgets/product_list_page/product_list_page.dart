import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tune_admin/provider/products_page_provider/products_page_provider.dart';
import 'package:my_tune_admin/provider/uploads_page_provider/uploads_page_provider.dart';
import 'package:my_tune_admin/widgets/product_list_page/widgets/custom_popup_button.dart';
import 'package:my_tune_admin/widgets/product_list_page/widgets/custom_text_form_field.dart';
import 'package:my_tune_admin/widgets/product_list_page/widgets/product_list_item.dart';
import 'package:provider/provider.dart';

import '../../general/constants.dart';
import '../uploads_page/widgets/category_list_item.dart';
import '../users_page/widgets/custom_search_field.dart';
import 'widgets/add_product_dialog_box.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    TextEditingController titleController = TextEditingController();

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
            actions: [
              IconButton(
                onPressed: () async {
                  await showDialogMeassage(context: context);
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              kSizedBoxW10
            ],
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: size.width >= 500 ? 50 : 20,
                  right: size.width >= 500 ? 50 : 20,
                ),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  // width: size.width * 0.25,
                  child: CustomSearchField(
                    hint: 'Search Video',
                    onFieldSubmitted: (value) async {},
                    onPress: () async {},
                    controller: titleController,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 1000,
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        // right: 10,
                        // left: 10,
                      ),
                      width: double.infinity,
                      height: 35,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(245, 204, 204, 204),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        children: [
                          kSizedBoxW10,
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Videos',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Center(
                              child: Text(
                                'Likes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Center(
                              child: Text(
                                'Visibility',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Center(
                              child: Text(
                                'Action',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    kSizedBoxH10,
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.only(top: 10),
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          state.categories.isNotEmpty
                              ? SliverList.builder(
                                  itemCount: state.categories.length,
                                  itemBuilder: (context, index) {
                                    final category = state.categories[index];
                                    return InkWell(
                                        onTap: () {
                                          state.showCategories(
                                            value: false,
                                            categoryId: category.id,
                                            name: category.categoryName,
                                          );
                                        },
                                        child: ProductListItem());
                                  })
                              : SliverFillRemaining(
                                  hasScrollBody: false,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: state.isLoading == false
                                          ? const Text(
                                              'Categories is empty!',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black38,
                                              ),
                                            )
                                          : const CupertinoActivityIndicator(),
                                    ),
                                  ),
                                ),
                          state.isDataEmpty == false &&
                                  state.categories.length >= 7
                              ? SliverToBoxAdapter(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    color: Colors.white,
                                    child: Center(
                                      child: MaterialButton(
                                        color: Colors.black,
                                        textColor: Colors.white,
                                        height: 50,
                                        minWidth: 200,
                                        onPressed: () async {},
                                        child: state.showCircularIndicater ==
                                                false
                                            ? const Text('Show more')
                                            : const CupertinoActivityIndicator(),
                                      ),
                                    ),
                                  ),
                                )
                              : const SliverToBoxAdapter(),
                          SliverPadding(
                            padding: const EdgeInsets.only(bottom: 20),
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showDialogMeassage({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Material(
            type: MaterialType.transparency,
            child: SingleChildScrollView(
              child: AddProductDialogBox(),
            ),
          );
        });
  }
}
