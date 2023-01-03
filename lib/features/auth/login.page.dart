

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ourpass_assessment/core/data/exception.dart';
import 'package:ourpass_assessment/core/data/local.cache.dart';
import 'package:ourpass_assessment/core/data/respository/auth.repository.dart';
import 'package:ourpass_assessment/core/domain/usecases/auth/auth.usecases.dart';
import 'package:ourpass_assessment/core/domain/usecases/auth/login.user.dart';
import 'package:ourpass_assessment/core/domain/usecases/auth/signup.user.dart';
import 'package:ourpass_assessment/features/auth/auth.viewmodel.dart';
import 'package:ourpass_assessment/features/auth/signup.page.dart';
import 'package:ourpass_assessment/home.page.dart';
import 'package:ourpass_assessment/utils/custom.colors.dart';
import 'package:ourpass_assessment/utils/mixins.dart';
import 'package:ourpass_assessment/widgets/custom.buttom.dart';
import 'package:ourpass_assessment/widgets/custom.text.field.dart';


class _Initials {
  static IAuthViewModel initiateVM() {
    final IAuthRepository authRepository = AuthRepository();
    final LoginUserUseCase loginUserUseCase = DefaultLoginUserUseCase(authRepository: authRepository);
    final AuthUsecase authUsecase = AuthUsecase(loginUserUseCase: loginUserUseCase);
    return AuthViewModel(authUsecase: authUsecase);
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> with InputValidationMixin, LoaderViewMixin {
  final IAuthViewModel authViewModel = _Initials.initiateVM();

  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final auth = LocalAuthentication();
  String authorized = " not authorized";
  bool _canCheckBiometric = false;
  late List<BiometricType> _availableBiometric;

  Future<void> _authenticate() async {
    bool authenticated = false;
    final isAuthenticated = await LocalCache.getBool(key: LocalCacheKeys.authenticated) ?? false;
    if (!isAuthenticated) return;

    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "Scan your finger to authenticate",
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }

    if (authenticated) {
      showSpinner(context: context);
      authViewModel.whenBiometricIsSuccessfull();
      hideSpinner(context: context);
    } else {
      setState(() {
        authorized =
        authenticated ? "Authorized success" : "Failed to authenticate";
        print(authorized);
      });
    }
  }

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future _getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    setState(() {
      _availableBiometric = availableBiometric;
    });
  }

  @override
  void initState() {
    _checkBiometric();
    _getAvailableBiometric();
    _authenticate();
    super.initState();
  }

  void _presentSignup() {
    Get.to(SignupPage());
  }

  void _presentHomePage() async {
    if (formGlobalKey.currentState?.validate() ?? false) {
      formGlobalKey.currentState?.save();
      showSpinner(context: context);
      ErrorMessage errorMessageIfAvailable = await authViewModel.login(emailController.text.trim(), passwordController.text.trim());
      hideSpinner(context: context);
      if (errorMessageIfAvailable != null) {
        Get.snackbar('', errorMessageIfAvailable);
        return;
      }
      Get.to(const HomePage());
    }
  }

  Widget _buildForm() {
    return Form(
      key: formGlobalKey,
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
            validator: (value) {
              if (isEmail(value)) {
                return null;
              } else {
                return 'Enter a valid email address';
              }
            },
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
            validator: (value) {
              if (isPasswordValid(value ?? "")) {
                return null;
              } else {
                return 'Enter a valid password';
              }
            },
          ),

          const SizedBox(height: 16.0,),

          CustomButton(text: "Sign In", onTap: _presentHomePage)
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
            onTap: _presentSignup,
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