import 'package:flutter/material.dart';
import 'package:my_tune_admin/model/product_model/product_model.dart';
import 'package:my_tune_admin/provider/products_page_provider/products_page_provider.dart';
import 'package:provider/provider.dart';

class CustomSwitchButton extends StatefulWidget {
  const CustomSwitchButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<CustomSwitchButton> createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton> {
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Switch(
          activeColor: Colors.green,
          thumbIcon: thumbIcon,
          value: widget.product.visibility,
          onChanged: (bool value) async {
            await Provider.of<ProductPageProvider>(
              context,
              listen: false,
            ).changeProductVisibility(
              productModel: widget.product,
              value: value,
            );
          },
        ),
      ],
    );
  }
}
