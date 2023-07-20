import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../enums/enums.dart';
import '../../general/constants.dart';
import '../../model/product_model/product_model.dart';
import '../../provider/todays_release/product_search_provider.dart';

import '../../provider/trending_page_provider/trending_page_provider.dart';

import '../product_list_page/widgets/update_product_dialog_box.dart';
import '../sheared/sheared_product_search_box.dart';
import '../users_page/widgets/custom_search_field.dart';
import 'widgets/product_list_item.dart';

class TrendingPageWidget extends StatefulWidget {
  const TrendingPageWidget({super.key});

  @override
  State<TrendingPageWidget> createState() => _TrendingPageWidgetState();
}

class _TrendingPageWidgetState extends State<TrendingPageWidget> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    TextEditingController searchController = TextEditingController();
    TextEditingController productSearchController = TextEditingController();

    return Consumer2<TrendingPageProvider, ProductSearchProvider>(
      builder: (context, state, state1, _) => Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Trending',
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
                                collectionName: 'isTodayRelease',
                                rState: ReleaseState.trending,
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
                      state.clearfetcedData();
                      await state.searchTrendingReleaseByLimit(
                        productName: searchController.text,
                        value: true,
                        getProductState: GetDataState.search,
                      );
                    },
                    onPress: () async {
                      state.clearfetcedData();
                      searchController.clear();

                      await state.getTrendingReleaseByLimit(
                        productState: GetDataState.normal,
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
                          state.isDataEmpty == false &&
                                  state.products.length >= 7
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
                                          state.getTrendingReleaseByLimit(
                                            productState: GetDataState.normal,
                                          );
                                        },
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
