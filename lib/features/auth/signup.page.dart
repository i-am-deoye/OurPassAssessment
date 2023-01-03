

import 'package:flutter/material.dart';
import 'package:ourpass_assessment/core/data/exception.dart';
import 'package:ourpass_assessment/features/auth/auth.viewmodel.dart';
import 'package:ourpass_assessment/features/auth/otp.page.dart';
import 'package:ourpass_assessment/utils/custom.colors.dart';
import 'package:ourpass_assessment/utils/mixins.dart';
import 'package:ourpass_assessment/widgets/custom.buttom.dart';
import 'package:ourpass_assessment/widgets/custom.text.field.dart';
import 'package:get/get.dart';

import '../../core/data/respository/auth.repository.dart';
import '../../core/domain/usecases/auth/auth.usecases.dart';
import '../../core/domain/usecases/auth/login.user.dart';
import '../../core/domain/usecases/auth/signup.user.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPage createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> with InputValidationMixin {


  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _dismissPage() {
    Get.back();
  }

  void _presentOTPPage() async {
    if (formGlobalKey.currentState?.validate() ?? false) {
      formGlobalKey.currentState?.save();
      Get.to(OTPPage(), arguments: [
        {'name': nameController.text.trim()},
        {'email': emailController.text.trim()},
        {'password': passwordController.text.trim()}
      ]);
    }
  }


  Widget _buildForm() {
    return Form(
      key: formGlobalKey,
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
            controller: nameController,
            hintText: 'Full Name',
            inputType: TextInputType.text,
            secure: false,
            validator: (String? value) {
              if (isRequired(value)) {
                return null;
              } else {
                return 'Full Name is required';
              }
            },
          ),

          const SizedBox(height: 16.0,),

          CustomTextField(
            controller: emailController,
            hintText: 'Email',
            inputType: TextInputType.emailAddress,
            secure: false,
            validator: (String? value) {
              if (isEmail(value)) {
                return null;
              } else {
                return 'Enter a valid email address';
              }
            },
          ),

          const SizedBox(height: 16.0,),

          CustomTextField(
            controller: passwordController,
            hintText: 'Password',
            inputType: TextInputType.text,
            secure: true,
            validator: (String? value) {
              if (isPasswordValid(value ?? "")) {
                return null;
              } else {
                return 'Valid password is required';
              }
            },
          ),

          const SizedBox(height: 16.0,),

          CustomButton(text: "Sign Up", onTap: _presentOTPPage)
        ],
      ),
    );
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
              child: _buildForm(),
            ),
          ),
        ),

        bottomNavigationBar: Container(
          height: 50,
          alignment: Alignment.center,
          child: InkWell(
            onTap: _dismissPage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                Text(
                  "Sign up",
                  style: TextStyle(
                    color: CustomColors.appColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}