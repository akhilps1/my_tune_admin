import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tune_admin/general/constants.dart';
import 'package:my_tune_admin/model/uploads_model/category_model.dart';
import 'package:my_tune_admin/pages/banner_list_page/widgets/custom_catched_network.dart';
import 'package:my_tune_admin/provider/products_page_provider/category_search_provider.dart';
import 'package:my_tune_admin/provider/products_page_provider/products_page_provider.dart';
import 'package:provider/provider.dart';

class CustomSearchWidget extends StatefulWidget {
  const CustomSearchWidget({super.key});

  @override
  State<CustomSearchWidget> createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  bool radioValue = true;

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController(text: "");
    return Consumer3<ProductPageProvider, CategorySearchProvider,
        ChangeRadioValue>(
      builder: (context, state1, state2, state, _) {
        return Column(
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(
                left: 15,
                right: 16,
                top: 10,
                bottom: 16,
              ),
              // height: 400,
              width: 400,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(children: [
                Row(children: [
                  const Spacer(),
                  const Text(
                    'Search creaft and crew',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.black54,
                    ),
                  )
                ]),
                kSizedBoxH10,
                TextFormField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  onChanged: (value) {
                    if (state2.lastDoc != null) {
                      state2.clearLastDoc();
                    }
                  },
                  onFieldSubmitted: (value) async {
                    await state2.searhCategory(categoryName: value);
                  },
                  decoration: InputDecoration(
                    hoverColor: Colors.blue[400]!.withOpacity(0.2),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchController.clear();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                    ),
                    hintText: 'Search carft and crew',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: EdgeInsets.zero,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      gapPadding: 0,
                    ),
                  ),
                ),
                kSizedBoxH10,
                Container(
                  height: 250,
                  width: 400,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: CustomScrollView(
                    slivers: [
                      state2.isLoading == false && state2.categories.isNotEmpty
                          ? SliverList.builder(
                              itemCount: state2.categories.length,
                              itemBuilder: (context, index) {
                                final CategoryModel category =
                                    state2.categories[index];
                                return Container(
                                  height: 75,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black.withOpacity(0.1),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        kSizedBoxW10,
                                        SizedBox(
                                          height: 65,
                                          width: 65,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            child: CustomCatchedNetworkImage(
                                              url: category.imageUrl,
                                            ),
                                          ),
                                        ),
                                        kSizedBoxW10,
                                        SizedBox(
                                          width: 70,
                                          child: Text(
                                            category.categoryName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black38,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(children: [
                                          SizedBox(
                                            width: 70,
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: true,
                                                  groupValue: category.isCraft,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  onChanged: (value) {
                                                    category
                                                        .changeCraftOrCrew();
                                                    state.setValue(
                                                      category.isCraft,
                                                    );
                                                  },
                                                ),
                                                const Text('Craft')
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 70,
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: false,
                                                  groupValue: category.isCraft,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  onChanged: (value) {
                                                    category
                                                        .changeCraftOrCrew();

                                                    state.setValue(
                                                      category.isCraft,
                                                    );
                                                  },
                                                ),
                                                const Text('Crew')
                                              ],
                                            ),
                                          ),
                                        ]),
                                        IconButton(
                                          onPressed: () {
                                            state2.addCategoryToTemp(
                                              category: category,
                                            );
                                            state2.removeCategory(
                                              category: category,
                                            );
                                          },
                                          icon: const Icon(Icons.add),
                                        ),
                                        kSizedBoxW10,
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : SliverFillRemaining(
                              child: Center(
                                child: state2.isLoading == true
                                    ? const CupertinoActivityIndicator()
                                    : const Text('Search craft and crew'),
                              ),
                            ),
                    ],
                  ),
                )
              ]),
            ),
            const Spacer(),
          ],
        );
      },
    );
  }
}
