

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ourpass_assessment/splash.page.dart';
import 'package:ourpass_assessment/utils/custom.colors.dart';

class HomePage extends StatelessWidget  {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Home Page ${FirebaseAuth.instance.currentUser?.displayName ?? ""}",
          style: TextStyle(
            color: CustomColors.appColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      bottomNavigationBar: ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Get.to(const SplashPage());
          },
          child: const Text('Log Out')),
    );
  }
}