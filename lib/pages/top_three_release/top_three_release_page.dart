import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tune_admin/enums/enums.dart';

import 'package:my_tune_admin/pages/product_list_page/widgets/update_product_dialog_box.dart';
import 'package:my_tune_admin/provider/todays_release/product_search_provider.dart';

import 'package:provider/provider.dart';

import '../../general/constants.dart';

import '../../model/product_model/product_model.dart';

import '../../provider/top_three_release/top_three_release_provider.dart';
import '../sheared/sheared_product_search_box.dart';

import 'widgets/product_list_item.dart';

class TopThreeReleasePageWidget extends StatelessWidget {
  const TopThreeReleasePageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    TextEditingController productSearchController = TextEditingController();

    return Consumer2<TopThreeReleasePageProvider, ProductSearchProvider>(
      builder: (context, state, state1, _) => Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Top Three Release',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            elevation: 2,
            actions: [
              IconButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Material(
                          type: MaterialType.transparency,
                          child: ShearedProductSearchBox(
                            searchController: productSearchController,
                            onClose: () {
                              Navigator.pop(context);
                            },
                            onClearTextClicked: () {
                              state1.clearProduct();
                              productSearchController.clear();
                            },
                            onTextChanged: (value) {
                              if (state1.lastDoc != null) {
                                state1.clearProduct();
                              }
                            },
                            onTextSubmitted: (value) async {
                              await state1.searchProducts(
                                productName: value,
                                collectionName: 'isTopThree',
                                rState: ReleaseState.top3,
                              );
                            },
                          ),
                        );
                      });
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              kSizedBoxW10
            ],
          ),
          Expanded(
            flex: 1,
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
                            flex: 4,
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
                          state.products.isNotEmpty
                              ? SliverList.builder(
                                  itemCount: state.products.length,
                                  itemBuilder: (context, index) {
                                    final product = state.products[index];

                                    return ProductListItem(
                                      product: product,
                                      onEditPresed: () async {
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
                                      child: state.isLoading == false
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
}
