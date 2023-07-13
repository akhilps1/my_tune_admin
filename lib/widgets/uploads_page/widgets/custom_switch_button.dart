import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_tune_admin/model/uploads_page_model/category_model.dart';
import 'package:my_tune_admin/provider/uploads_page_provider/uploads_page_provider.dart';
import 'package:provider/provider.dart';

class CustomSwitchButton extends StatefulWidget {
  const CustomSwitchButton({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

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
          value: widget.categoryModel.visibility,
          onChanged: (bool value) {
            Provider.of<UploadsPageProvider>(context, listen: false)
                .changeCategoryVisibility(
              categoryModel: widget.categoryModel,
              value: value,
            );
            log(value.toString());
          },
        ),
      ],
    );
  }
}
