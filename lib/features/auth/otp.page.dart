

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ourpass_assessment/utils/custom.colors.dart';
import 'package:ourpass_assessment/widgets/custom.input.otp.dart';


mixin _ViewBuilderMixin {
  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  final TextEditingController thirdController = TextEditingController();
  final TextEditingController fourthController = TextEditingController();

  Widget _buildForm() {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InputOtp(controller: firstController, textHint: "1", onEvent: _presentHomePage,),
          InputOtp(controller: secondController, textHint: "2", onEvent: _presentHomePage),
          InputOtp(controller: thirdController, textHint: "3", onEvent: _presentHomePage),
          InputOtp(controller: fourthController, textHint: "4", onEvent: _presentHomePage),
        ],
      ),
    );
  }

  void _presentHomePage();
}

class OTPPage extends StatelessWidget with _ViewBuilderMixin {
  OTPPage({Key? key}): super(key: key);

  @override
  void _presentHomePage() {
    if (formGlobalKey.currentState?.validate() ?? false) {
      formGlobalKey.currentState?.save();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 64.0,),

                Text(
                  "Please enter OTP sent to your email (${Get.arguments}).",
                  style: TextStyle(
                      color: CustomColors.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300
                  ),
                ),

                const SizedBox(height: 38.0,),

                _buildForm()
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}
