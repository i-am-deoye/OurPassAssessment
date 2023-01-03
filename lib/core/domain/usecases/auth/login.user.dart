


import 'package:get/get.dart';
import 'package:ourpass_assessment/core/data/exception.dart';

import '../../../data/respository/auth.repository.dart';

mixin LoginUserUseCase {

  Future<StringError> execute(String email, String password) async {
    // TODO: implement execute
    throw UnimplementedError();
  }
}


class DefaultLoginUserUseCase implements LoginUserUseCase {
  DefaultLoginUserUseCase({required this.authRepository});

  final IAuthRepository authRepository;

  @override
  Future<StringError> execute(String email, String password) async {
    return authRepository.signIn(email, password);
  }
}