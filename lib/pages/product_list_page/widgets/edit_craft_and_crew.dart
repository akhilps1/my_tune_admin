import 'package:flutter/material.dart';
import 'package:my_tune_admin/general/constants.dart';

import 'package:my_tune_admin/model/uploads_model/category_model.dart';
import 'package:my_tune_admin/provider/products_page_provider/category_search_provider.dart';
import 'package:provider/provider.dart';

class EditCraftAndCrew extends StatelessWidget {
  const EditCraftAndCrew({super.key, this.categoryList});

  final List<CategoryModel>? categoryList;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategorySearchProvider>(
      builder: (context, state, _) => CustomScrollView(
        slivers: [
          state.categoriesTemp.isNotEmpty
              ? SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 6 / 1,
                  ),
                  itemCount: state.categoriesTemp.length,
                  itemBuilder: (context, index) {
                    final CategoryModel category =
                        state.categoriesTemp.toList()[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        children: [
                          kSizedBoxW5,
                          Text(
                            category.categoryName,
                          ),
                          kSizedBoxW5,
                          Text(category.isCraft == true ? '(Craft)' : '(Crew)'),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              state.removeCategoryFromTemp(
                                category: category,
                              );
                            },
                            hoverColor: Colors.white.withOpacity(0.5),
                            child: Icon(
                              Icons.close,
                              size: 20,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          kSizedBoxW5,
                        ],
                      ),
                    );
                  },
                )
              : const SliverFillRemaining(
                  child: Center(
                    child: Text('Add craft and crew'),
                  ),
                ),
        ],
      ),
    );
  }
}
