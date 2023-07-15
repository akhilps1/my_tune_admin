import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.errorMeassage,
    required this.title,
    required this.hint,
  });

  final TextEditingController controller;
  final String errorMeassage;
  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMeassage;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: title,
        hintText: hint,
        border: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
        )),
      ),
    );
  }
}
