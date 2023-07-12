import 'dart:developer';

import 'package:flutter/material.dart';

class CustomSwitchButton extends StatefulWidget {
  const CustomSwitchButton({super.key, required this.value});

  final bool value;

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
          value: widget.value,
          onChanged: (bool value) {
            log(value.toString());
          },
        ),
      ],
    );
  }
}
