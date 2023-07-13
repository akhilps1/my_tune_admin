import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    Key? key,
    required this.hint,
    this.onFieldSubmitted,
    required this.onPress,
    required this.controller,
    this.inputFormatters,
  }) : super(key: key);

  final String hint;

  final Function(String)? onFieldSubmitted;
  final VoidCallback onPress;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: inputFormatters,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hoverColor: Colors.blue[400]!.withOpacity(0.2),
        prefixIcon: const Icon(
          Icons.search,
          size: 20,
        ),
        suffixIcon: IconButton(
          onPressed: onPress,
          icon: const Icon(
            Icons.close,
            size: 20,
          ),
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: EdgeInsets.zero,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          gapPadding: 0,
        ),
      ),
    );
  }
}
