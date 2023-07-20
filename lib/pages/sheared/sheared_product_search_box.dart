import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tune_admin/enums/enums.dart';
import 'package:my_tune_admin/general/constants.dart';
import 'package:my_tune_admin/model/product_model/product_model.dart';

import 'package:my_tune_admin/pages/banner_list_page/widgets/custom_catched_network.dart';
import 'package:my_tune_admin/provider/todays_release/product_search_provider.dart';
import 'package:my_tune_admin/provider/todays_release/todays_release_provider.dart';
import 'package:my_tune_admin/provider/top_three_release/top_three_release_provider.dart';
import 'package:my_tune_admin/provider/trending_page_provider/trending_page_provider.dart';
import 'package:provider/provider.dart';

class ShearedProductSearchBox extends StatelessWidget {
  const ShearedProductSearchBox({
    super.key,
    required this.onClose,
    required this.onClearTextClicked,
    required this.onTextChanged,
    required this.onTextSubmitted,
    required this.searchController,
  });

  final VoidCallback onClose;
  final VoidCallback onClearTextClicked;

  final TextEditingController searchController;

  final Function(String) onTextChanged;
  final Function(String) onTextSubmitted;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductSearchProvider>(
      builder: (context, state, _) => Column(
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
                const Text(
                  'Search here',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: onClose,
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
                onChanged: onTextChanged,
                onFieldSubmitted: onTextSubmitted,
                decoration: InputDecoration(
                  hoverColor: Colors.blue[400]!.withOpacity(0.2),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 20,
                  ),
                  suffixIcon: IconButton(
                    onPressed: onClearTextClicked,
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                  hintText: 'Search somthing...',
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
                    state.isLoading == false && state.products.isNotEmpty
                        ? SliverList.builder(
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              final product = state.products[index];
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
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          child: CustomCatchedNetworkImage(
                                            url: product.imageUrl,
                                          ),
                                        ),
                                      ),
                                      kSizedBoxW10,
                                      SizedBox(
                                        width: 70,
                                        child: Text(
                                          product.title,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () async {
                                          switch (state.releaseState) {
                                            case ReleaseState.today:
                                              await Provider.of<
                                                  TodaysReleaseProvider>(
                                                context,
                                                listen: false,
                                              ).updateTodayRelease(
                                                productModel: product,
                                              );
                                              break;

                                            case ReleaseState.top3:
                                              await Provider.of<
                                                  TopThreeReleasePageProvider>(
                                                context,
                                                listen: false,
                                              ).updateTopThreeRelease(
                                                productModel: product,
                                              );
                                              break;
                                            case ReleaseState.trending:
                                              await Provider.of<
                                                  TrendingPageProvider>(
                                                context,
                                                listen: false,
                                              ).updateTrendingRelease(
                                                productModel: product,
                                              );
                                              break;
                                          }
                                          state.clearProduct();
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
                              child: state.isLoading == true
                                  ? const CupertinoActivityIndicator()
                                  : const Text(
                                      'Search videos...',
                                    ),
                            ),
                          ),
                  ],
                ),
              )
            ]),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
