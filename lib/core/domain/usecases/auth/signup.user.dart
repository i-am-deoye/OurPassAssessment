


import 'package:get/get.dart';
import 'package:ourpass_assessment/core/data/exception.dart';

import '../../../data/respository/auth.repository.dart';

mixin SignupUseCase {

  Future<ErrorMessage> execute(String name, String email, String password) async {
    // TODO: implement execute
    throw UnimplementedError();
  }
}


class DefaultSignupUseCase implements SignupUseCase {
  DefaultSignupUseCase({required this.authRepository});

  final IAuthRepository authRepository;

  @override
  Future<ErrorMessage> execute(String name, String email, String password) async {
    return authRepository.create(name, email, password);
  }
}
