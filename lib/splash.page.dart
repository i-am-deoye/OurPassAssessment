
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ourpass_assessment/login.page.dart';
import 'package:ourpass_assessment/utils/custom.colors.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {Get.to(const LoginPage());});

    return Scaffold(
      backgroundColor: CustomColors.appColor,
      body: const Center(
        child: Text(
          "Pass.Assessment",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}