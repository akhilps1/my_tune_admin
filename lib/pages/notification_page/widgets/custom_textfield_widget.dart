import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.validator,
    this.maxLines,
  });
  final TextEditingController controller;
  final String hint;
  final String Function(String? value)? validator;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
        // errorBorder: const OutlineInputBorder(),
      ),
    );
  }
}
