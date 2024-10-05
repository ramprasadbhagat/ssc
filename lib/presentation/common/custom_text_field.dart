import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String? val) validator;
  final String labelText;
  final TextInputType keyboardType;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.validator,
      this.keyboardType = TextInputType.text,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.brown.shade600,fontWeight: FontWeight.bold),
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      validator: validator,
    );
  }
}
