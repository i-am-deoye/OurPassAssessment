
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ourpass_assessment/features/auth/login.page.dart';
import 'package:ourpass_assessment/utils/custom.colors.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);


  void segue() async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;
    if (user != null) {
      Get.to(LoginPage());
    } else {
      Get.to(LoginPage());
    }
  }


  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), segue);

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