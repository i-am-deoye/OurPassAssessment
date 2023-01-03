


import 'package:ourpass_assessment/core/data/exception.dart';
import 'package:ourpass_assessment/core/data/local.cache.dart';

import '../../core/domain/usecases/auth/auth.usecases.dart';

mixin IAuthViewModel {
  Future<ErrorMessage> login(String email, String password) async {
    // TODO: implement login
    throw UnimplementedError();
  }

  Future<ErrorMessage> create(String name, String email, String password) async {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<ErrorMessage> whenBiometricIsSuccessfull() async {
    // TODO: implement create
    throw UnimplementedError();
  }
}


class AuthViewModel implements IAuthViewModel {
  AuthViewModel({ required this.authUsecase});

  final AuthUsecase authUsecase;

  @override
  Future<ErrorMessage> login(String email, String password) async {
    return await authUsecase.loginUserUseCase?.execute(email, password);
  }

  @override
  Future<ErrorMessage> whenBiometricIsSuccessfull() async {
    final email = await LocalCache.getString(key: LocalCacheKeys.email) ?? "";
    final password = await LocalCache.getString(key: LocalCacheKeys.password) ?? "";
    return await authUsecase.loginUserUseCase?.execute(email, password);
  }

  @override
  Future<ErrorMessage> create(String name, String email, String password) async {
    return await authUsecase.signupUseCase?.execute(name, email, password);
  }
}