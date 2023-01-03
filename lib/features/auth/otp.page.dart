

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ourpass_assessment/core/data/exception.dart';
import 'package:ourpass_assessment/utils/custom.colors.dart';
import 'package:ourpass_assessment/utils/mixins.dart';
import 'package:ourpass_assessment/widgets/custom.input.otp.dart';

import '../../core/data/respository/auth.repository.dart';
import '../../core/domain/usecases/auth/auth.usecases.dart';
import '../../core/domain/usecases/auth/signup.user.dart';
import 'auth.viewmodel.dart';


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

class _Initials {
  static IAuthViewModel initiateVM() {
    final IAuthRepository authRepository = AuthRepository();
    final SignupUseCase signupUseCase = DefaultSignupUseCase(authRepository: authRepository);
    final AuthUsecase authUsecase = AuthUsecase(signupUseCase: signupUseCase);
    return AuthViewModel(authUsecase: authUsecase);
  }
}

class _OTPPage extends GetxController {
}

class OTPPage extends _OTPPage with _ViewBuilderMixin, LoaderViewMixin {
  final IAuthViewModel authViewModel = _Initials.initiateVM();
  final BuildContext context = Get.context!;

  void _presentHomePage() async {
    if (formGlobalKey.currentState?.validate() ?? false) {
      formGlobalKey.currentState?.save();
      showSpinner(context: context);

      final name = Get.arguments[0]['name'] as String;
      final email = Get.arguments[1]['email'] as String;
      final password = Get.arguments[2]['password'] as String;

      StringError errorMessageIfAvailable = await authViewModel.create(
          name,
          email,
          password);
      hideSpinner(context: context);

      if (errorMessageIfAvailable != null) {
        Get.snackbar('', errorMessageIfAvailable);
        return;
      }
      Get.to(OTPPage());
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

