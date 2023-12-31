import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tune_admin/enums/enums.dart';
import 'package:my_tune_admin/model/uploads_model/category_model.dart';
import 'package:my_tune_admin/pages/product_list_page/widgets/update_product_dialog_box.dart';
import 'package:my_tune_admin/provider/products_page_provider/products_page_provider.dart';
import 'package:my_tune_admin/provider/uploads_page_provider/uploads_page_provider.dart';

import 'package:my_tune_admin/pages/product_list_page/widgets/product_list_item.dart';
import 'package:provider/provider.dart';

import '../../general/constants.dart';

import '../../model/product_model/product_model.dart';
import '../../provider/products_page_provider/category_search_provider.dart';
import '../users_page/widgets/custom_search_field.dart';
import 'widgets/add_product_dialog_box.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    TextEditingController searchController = TextEditingController();

    return Consumer2<UploadsPageProvider, ProductPageProvider>(
      builder: (context, state, state1, _) => Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                state1.clearfetcedData();
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
                    onChanged: (value) {},
                    onFieldSubmitted: (value) async {
                      state1.clearfetcedData();
                      await state1.searhProduct(
                        productName: searchController.text,
                        getProductState: GetDataState.search,
                      );
                    },
                    onPress: () async {
                      state1.clearfetcedData();
                      searchController.clear();

                      await state1.getProductsByLimit(
                        productState: GetDataState.normal,
                        id: state1.categoryId!,
                      );
                    },
                    controller: searchController,
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
                          state1.products.isNotEmpty
                              ? SliverList.builder(
                                  itemCount: state1.products.length,
                                  itemBuilder: (context, index) {
                                    final product = state1.products[index];

                                    return ProductListItem(
                                      product: product,
                                      onEditPresed: () async {
                                        Provider.of<CategorySearchProvider>(
                                          context,
                                          listen: false,
                                        ).setCategoryTemp(
                                          product.categories,
                                        );
                                        await showEditDialogMeassage(
                                          context: context,
                                          productModel: product,
                                        );
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                      },
                                    );
                                  })
                              : SliverFillRemaining(
                                  hasScrollBody: true,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: state1.isLoading == false
                                          ? const Text(
                                              'Videos is empty!',
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
                          state1.isDataEmpty == false &&
                                  state1.products.length >= 7
                              ? SliverToBoxAdapter(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    color: Colors.white,
                                    child: Center(
                                      child: MaterialButton(
                                        color: Colors.black,
                                        textColor: Colors.white,
                                        height: 50,
                                        minWidth: 200,
                                        onPressed: () async {
                                          state1.getProductsByLimit(
                                            productState: GetDataState.normal,
                                            id: state1.categoryId!,
                                          );
                                        },
                                        child: state1.showCircularIndicater ==
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

  Future showEditDialogMeassage(
      {required BuildContext context, required ProductModel productModel}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            type: MaterialType.transparency,
            child: SingleChildScrollView(
              child: UpdateProductDialogBox(
                productModel: productModel,
              ),
            ),
          );
        });
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
