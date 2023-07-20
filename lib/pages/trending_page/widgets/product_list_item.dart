import 'package:flutter/material.dart';
import 'package:my_tune_admin/general/constants.dart';
import 'package:my_tune_admin/model/product_model/product_model.dart';

import 'package:my_tune_admin/pages/banner_list_page/widgets/custom_catched_network.dart';
import 'package:my_tune_admin/provider/trending_page_provider/trending_page_provider.dart';
import 'package:provider/provider.dart';

import '../../../serveice/custom_popup.dart';
import '../../../serveice/number_converter.dart';

class ProductListItem extends StatefulWidget {
  const ProductListItem({
    super.key,
    required this.product,
    required this.onEditPresed,
  });

  final ProductModel product;
  final VoidCallback onEditPresed;

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
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
            Flexible(
              flex: 6,
              fit: FlexFit.tight,
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
                        url: widget.product.imageUrl,
                      ),
                    ),
                  ),
                  kSizedBoxW10,
                  kSizedBoxW10,
                  Wrap(direction: Axis.vertical, children: [
                    SizedBox(
                      width: 250,
                      child: Text(
                        widget.product.title,
                        maxLines: 1,
                        softWrap: true,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    kSizedBoxH5,
                    SizedBox(
                      width: 300,
                      child: Text(
                        widget.product.categories
                            .map((e) => e.categoryName)
                            .toString()
                            .replaceAll('(', '')
                            .replaceAll(')', ''),
                        maxLines: 1,
                        softWrap: true,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    kSizedBoxH5,
                    SizedBox(
                      width: 350,
                      child: Text(
                        widget.product.description,
                        maxLines: 1,
                        softWrap: true,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  NumberFormatter.format(
                    value: widget.product.likes,
                  ),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: PopupMenuButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onSelected: (value) {
                    if (value == 'delete') {
                      CustomPopup.showPopup(
                        context: context,
                        title: 'Do you want to remove this ?',
                        content: '',
                        buttonText: 'Yes',
                        onPressed: () async {
                          await Provider.of<TrendingPageProvider>(
                            context,
                            listen: false,
                          ).removeTrendingRelease(
                            productModel: widget.product,
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        },
                      );
                    }
                  },
                  itemBuilder: ((context) {
                    return <PopupMenuEntry>[
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                            kSizedBoxW10,
                            Text('delete'),
                          ],
                        ),
                      ),
                    ];
                  }),
                ))
          ],
        ),
      ),
    );
  }
}
