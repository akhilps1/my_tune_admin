import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tune_admin/enums/enums.dart';
import 'package:my_tune_admin/provider/products_page_provider/products_page_provider.dart';
import 'package:my_tune_admin/provider/uploads_page_provider/uploads_page_provider.dart';
import 'package:my_tune_admin/pages/product_list_page/product_list_page.dart';
import 'package:my_tune_admin/pages/uploads_page/widgets/add_category_dialog_box.dart';
import 'package:my_tune_admin/pages/uploads_page/widgets/category_list_item.dart';
import 'package:my_tune_admin/pages/users_page/widgets/custom_search_field.dart';
import 'package:provider/provider.dart';

import '../../general/constants.dart';

class UploadsPageWidget extends StatefulWidget {
  const UploadsPageWidget({super.key});

  @override
  State<UploadsPageWidget> createState() => _UploadsPageWidgetState();
}

class _UploadsPageWidgetState extends State<UploadsPageWidget> {
  TextEditingController controller = SearchController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Provider.of<UploadsPageProvider>(context).show == true
        ? Consumer<UploadsPageProvider>(
            builder: (context, state, _) => Column(
              children: [
                AppBar(
                  backgroundColor: Colors.white,
                  title: const Text(
                    'Categories',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  elevation: 1,
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
                          hint: 'Search Category',
                          onChanged: (value) {},
                          onFieldSubmitted: (value) async {
                            state.clearDoc();
                            await state.searhCategory(
                              categoryName: controller.text.toLowerCase(),
                              categoryState: GetDataState.search,
                            );
                          },
                          onPress: () async {
                            controller.clear();
                            await state.getCategoriesByLimit(
                              categoryState: GetDataState.normal,
                            );
                          },
                          controller: controller,
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
                                    'Ctaegories',
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
                                      'Followers',
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
                                          final category =
                                              state.categories[index];
                                          return InkWell(
                                            onTap: () async {
                                              state.showCategories(
                                                value: false,
                                                categoryId: category.id,
                                                name: category.categoryName,
                                              );

                                              await Provider.of<
                                                  ProductPageProvider>(
                                                context,
                                                listen: false,
                                              ).getProductsByLimit(
                                                productState:
                                                    GetDataState.normal,
                                                id: category.id!,
                                              );

                                              log('categoryId: ${category.id}');
                                            },
                                            child: CategoryListItem(
                                              categoryModel: category,
                                            ),
                                          );
                                        })
                                    : SliverFillRemaining(
                                        fillOverscroll: true,
                                        child: Container(
                                          color: Colors.white,
                                          child: Center(
                                            child: state.isLoading == false
                                                ? const Text(
                                                    'Categories is empty!',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              onPressed: () async {
                                                state.getCategoriesByLimit(
                                                  categoryState:
                                                      GetDataState.normal,
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
          )
        : const ProductListPage();
  }

  Future showDialogMeassage({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Material(
            type: MaterialType.transparency,
            child: AddCategoryDialogBox(),
          );
        });
  }
}
