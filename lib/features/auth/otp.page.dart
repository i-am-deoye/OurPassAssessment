

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ourpass_assessment/core/data/exception.dart';
import 'package:ourpass_assessment/home.page.dart';
import 'package:ourpass_assessment/utils/custom.colors.dart';
import 'package:ourpass_assessment/utils/mixins.dart';
import 'package:ourpass_assessment/widgets/custom.buttom.dart';
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
          InputOtp(controller: firstController, textHint: "1", onEvent: (){},),
          InputOtp(controller: secondController, textHint: "2", onEvent: (){}),
          InputOtp(controller: thirdController, textHint: "3", onEvent: (){}),
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

class OTPPage extends StatefulWidget {
  const OTPPage({super.key, required this.name, required this.email, required this.password});

  final String name;
  final String email;
  final String password;



  @override
  _OTPPage createState() => _OTPPage();
}

class _OTPPage extends State<OTPPage> with _ViewBuilderMixin, LoaderViewMixin {
  final IAuthViewModel authViewModel = _Initials.initiateVM();

  void _presentHomePage() async {
    if (formGlobalKey.currentState?.validate() ?? false) {
      formGlobalKey.currentState?.save();
      showSpinner(context: context);

      final name = widget.name;
      final email = widget.email;
      final password = widget.password;

      ErrorMessage errorMessageIfAvailable = await authViewModel.create(
          name,
          email,
          password);
      hideSpinner(context: context);

      if (errorMessageIfAvailable != null) {
        Get.snackbar('', errorMessageIfAvailable);
        return;
      }
      Get.to(const HomePage());
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
                  "Please enter OTP sent to your email (${widget.email}).",
                  style: TextStyle(
                      color: CustomColors.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300
                  ),
                ),

                const SizedBox(height: 38.0,),

                _buildForm(),

                CustomButton(text: "Continue", onTap: _presentHomePage)
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}

