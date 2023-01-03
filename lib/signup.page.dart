

import 'package:flutter/material.dart';
import 'package:ourpass_assessment/utils/custom.colors.dart';
import 'package:ourpass_assessment/widgets/custom.buttom.dart';
import 'package:ourpass_assessment/widgets/custom.text.field.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}): super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _dismissPage() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 34.0,),

                  Text(
                    "Please signup here.",
                    style: TextStyle(
                        color: CustomColors.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w300
                    ),
                  ),

                  const SizedBox(height: 38.0,),

                  CustomTextField(
                    controller: emailController,
                    hintText: 'Full Name',
                    inputType: TextInputType.emailAddress,
                    secure: false,
                  ),

                  const SizedBox(height: 16.0,),

                  CustomTextField(
                    controller: emailController,
                    hintText: 'Email',
                    inputType: TextInputType.emailAddress,
                    secure: false,
                  ),

                  const SizedBox(height: 16.0,),

                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    inputType: TextInputType.text,
                    secure: true,
                  ),

                  const SizedBox(height: 16.0,),

                  CustomButton(text: "Sign Up", onTap: () { print("Sign in"); })
                ],
              ),
            ),
          ),
        ),

        bottomNavigationBar: Container(
          height: 50,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              InkWell(
                onTap: _dismissPage,
                child: Text(
                  "Sign in",
                  style: TextStyle(
                    color: CustomColors.appColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}