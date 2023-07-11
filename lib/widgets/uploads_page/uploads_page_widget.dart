import 'package:flutter/material.dart';
import 'package:my_tune_admin/widgets/add_product_page/widgets/add_category_dialog_box.dart';
import 'package:my_tune_admin/widgets/add_product_page/widgets/category_list_item.dart';
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
    // final Size size = MediaQuery.of(context).size;
    return Column(
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
              padding: const EdgeInsets.only(left: 50),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 300),
                // width: size.width * 0.25,
                child: CustomSearchField(
                  hint: 'Search Category',
                  onPress: () {},
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
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 0.3,
                    blurRadius: 0.2,
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      right: 10,
                      left: 10,
                    ),
                    width: double.infinity,
                    height: 35,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(245, 225, 225, 225),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      children: [
                        kSizedBoxW10,
                        Expanded(
                          flex: 4,
                          child: Text('Ctaegory'),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Center(child: Text('Status')),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Center(child: Text('Action')),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverList.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) =>
                              const CategoryListItem(),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 20,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: Center(
                              child: MaterialButton(
                                color: Colors.black,
                                textColor: Colors.white,
                                height: 50,
                                minWidth: 200,
                                onPressed: () async {},
                                child: const Text('Show more'),
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
        kSizedBoxH10,
        kSizedBoxH10,
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
