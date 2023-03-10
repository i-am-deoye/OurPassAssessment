

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.inputType,
    required this.secure,
    required this.validator}): super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;
  final bool secure;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 3, right: 15),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 7
          )
        ]
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: inputType,
        obscureText: secure,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(0),
          hintStyle: const TextStyle(
            height: 1
          )
        ),
      ),
    );
  }
}