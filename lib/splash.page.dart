
import 'package:flutter/material.dart';
import 'package:ourpass_assessment/utils/custom.colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
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