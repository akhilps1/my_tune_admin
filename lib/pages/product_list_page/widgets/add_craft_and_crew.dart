import 'package:flutter/material.dart';
import 'package:my_tune_admin/general/constants.dart';
import 'package:my_tune_admin/model/uploads_model/category_model.dart';
import 'package:my_tune_admin/provider/products_page_provider/products_page_provider.dart';
import 'package:provider/provider.dart';

class AddCraftAndCrew extends StatelessWidget {
  const AddCraftAndCrew({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductPageProvider>(
      builder: (context, state, _) => CustomScrollView(
        slivers: [
          state.categories.isNotEmpty
              ? SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 6 / 1,
                  ),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final CategoryModel category = state.categories[index];
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
                          const Spacer(),
                          InkWell(
                            onTap: () {},
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
