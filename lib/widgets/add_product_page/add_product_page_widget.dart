import 'package:flutter/material.dart';
import 'package:my_tune_admin/widgets/add_product_page/widgets/add_category_dialog_box.dart';
import 'package:my_tune_admin/widgets/users_page/widgets/custom_search_field.dart';

import '../../general/constants.dart';

class AddProductPageWidget extends StatefulWidget {
  const AddProductPageWidget({super.key});

  @override
  State<AddProductPageWidget> createState() => _AddProductPageWidgetState();
}

class _AddProductPageWidgetState extends State<AddProductPageWidget> {
  TextEditingController controller = SearchController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Category',
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
              padding: const EdgeInsets.only(left: 50),
              child: SizedBox(
                width: size.width * 0.25,
                child: CustomSearchField(
                    hint: 'Search Category',
                    onPress: () {},
                    controller: controller),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            color: Colors.red,
          ),
        )
      ],
    );
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
