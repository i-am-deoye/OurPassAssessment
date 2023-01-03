
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ourpass_assessment/features/auth/login.page.dart';
import 'package:ourpass_assessment/home.page.dart';
import 'package:ourpass_assessment/utils/custom.colors.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (
          BuildContext context,
          AsyncSnapshot<User?> snapshot,
          ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: CustomColors.appColor,
            body: const Center(
              child: Text(
                "Pass.Assessment",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.active
            || snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            print(snapshot.data);
            return const HomePage();
          } else {
            return LoginPage();
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
}


