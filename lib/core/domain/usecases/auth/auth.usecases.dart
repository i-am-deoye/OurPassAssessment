


import 'package:ourpass_assessment/core/domain/usecases/auth/login.user.dart';
import 'package:ourpass_assessment/core/domain/usecases/auth/signup.user.dart';

class AuthUsecase {
  final LoginUserUseCase? loginUserUseCase;
  final SignupUseCase? signupUseCase;

  AuthUsecase({this.loginUserUseCase, this.signupUseCase});
}