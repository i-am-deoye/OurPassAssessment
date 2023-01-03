

import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourpass_assessment/core/data/exception.dart';
import 'package:ourpass_assessment/core/data/local.cache.dart';
import 'package:ourpass_assessment/core/data/respository/base.remote.repository.dart';

abstract class IAuthRepository {
  Future<ErrorMessage> signIn(String email, String password) async {}
  Future<ErrorMessage> create(String name, String email, String password) async {}
}


class AuthRepository with BaseRemoteRepository implements IAuthRepository {

  @override
  Future<ErrorMessage> signIn(String email, String password) async {
    try {
      await authInstance.signInWithEmailAndPassword(email: email, password: password);
      LocalCache.setString(key: LocalCacheKeys.email, value: email);
      LocalCache.setString(key: LocalCacheKeys.password, value: password);
      LocalCache.setBool(key: LocalCacheKeys.authenticated, value: true);
    } on FirebaseAuthException catch (ex) {
      print(ex.toString());
      return ex.message;
    }
  }
  
  @override
  Future<ErrorMessage> create(String name, String email, String password) async {
    try {
      UserCredential credential =  await authInstance.createUserWithEmailAndPassword(email: email, password: password);
      LocalCache.setString(key: LocalCacheKeys.email, value: email);
      LocalCache.setString(key: LocalCacheKeys.password, value: password);
      LocalCache.setBool(key: LocalCacheKeys.authenticated, value: true);
      await credential.user?.updateDisplayName(name);
      print(credential.user?.displayName);
    } on FirebaseAuthException catch (ex) {
      return ex.message;
    }
  }
}