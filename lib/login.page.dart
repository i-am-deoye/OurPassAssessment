

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ourpass_assessment/signup.page.dart';
import 'package:ourpass_assessment/utils/custom.colors.dart';
import 'package:ourpass_assessment/widgets/custom.buttom.dart';
import 'package:ourpass_assessment/widgets/custom.text.field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}): super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  void _presentSignup() {
    Get.to(SignupPage());
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

                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Pass.Assessment",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CustomColors.appColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  const SizedBox(height: 64.0,),

                  Text(
                    "Please login here.",
                    style: TextStyle(
                        color: CustomColors.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w300
                    ),
                  ),

                  const SizedBox(height: 38.0,),

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

                  CustomButton(text: "Sign In", onTap: () { print("Sign in"); })
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
                onTap: _presentSignup,
                child: Text(
                    "Sign up",
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