


import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin InputValidationMixin {
  bool isPasswordValid(String? password) => (password ?? "").length >= 6;
  bool isRequired(String? value) => (value ?? "").isNotEmpty;
  bool isEmail(String? value) => GetUtils.isEmail(value ?? "");
}


mixin LoaderViewMixin {
  void showSpinner({required BuildContext context}) {
    showDialog(context: context, builder: (context) {
      return const Center(child: CircularProgressIndicator(),);
    });
  }

  void hideSpinner({required BuildContext context}) {
    Navigator.of(context).pop();
  }
}