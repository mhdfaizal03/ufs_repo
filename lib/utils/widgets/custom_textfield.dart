import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextInputType keyboardType;
  final String hintText;
  final String? Function(String?)? validator;
  TextEditingController controller;
  CustomTextfield(
      {super.key,
      this.keyboardType = TextInputType.text,
      required this.hintText,
      required this.controller,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
