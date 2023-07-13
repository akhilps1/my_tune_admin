import 'package:flutter/material.dart';
import 'package:my_tune_admin/general/constants.dart';
import 'package:my_tune_admin/model/uploads_page_model/category_model.dart';
import 'package:my_tune_admin/widgets/uploads_page/widgets/custom_popup_menu_button.dart';
import 'package:my_tune_admin/widgets/uploads_page/widgets/custom_switch_button.dart';
import 'package:my_tune_admin/widgets/banner_list_page/widgets/custom_catched_network.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    super.key,
    required this.categoryModel,
  });

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 100,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  kSizedBoxW10,
                  kSizedBoxW10,
                  SizedBox(
                    height: 85,
                    width: 85,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: CustomCatchedNetworkImage(
                        url: categoryModel.imageUrl,
                      ),
                    ),
                  ),
                  kSizedBoxW10,
                  Text(
                    categoryModel.categoryName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: CustomSwitchButton(
                categoryModel: categoryModel,
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: CustomPopupMenuButton(
                categoryModel: categoryModel,
              ),
            )
          ],
        ),
      ),
    );
  }
}
