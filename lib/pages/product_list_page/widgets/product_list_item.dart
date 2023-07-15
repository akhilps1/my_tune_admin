import 'package:flutter/material.dart';
import 'package:my_tune_admin/general/constants.dart';

import 'package:my_tune_admin/pages/banner_list_page/widgets/custom_catched_network.dart';

import '../../../serveice/number_converter.dart';
import 'custom_popup_button.dart';
import 'custom_switch_button.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    super.key,
  });

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
            const Flexible(
              flex: 4,
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
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: CustomCatchedNetworkImage(
                        url: 'https://picsum.photos/id/237/536/354',
                      ),
                    ),
                  ),
                  kSizedBoxW10,
                  kSizedBoxW10,
                  Wrap(direction: Axis.vertical, children: [
                    SizedBox(
                      width: 250,
                      child: Text(
                        'Lorem Ipsum is simply dummy ',
                        maxLines: 1,
                        softWrap: true,
                        style: TextStyle(
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
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                        maxLines: 1,
                        softWrap: true,
                        style: TextStyle(
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
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                        maxLines: 1,
                        softWrap: true,
                        style: TextStyle(
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
                    value: 1000,
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
              child: CustomSwitchButton(),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: CustomPopupButton(),
            )
          ],
        ),
      ),
    );
  }
}
