

import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourpass_assessment/core/data/exception.dart';
import 'package:ourpass_assessment/core/data/respository/base.remote.repository.dart';

abstract class IAuthRepository {
  Future<StringError> signIn(String email, String password) async {}
  Future<StringError> create(String name, String email, String password) async {}
}


class AuthRepository with BaseRemoteRepository implements IAuthRepository {

  @override
  Future<StringError> signIn(String email, String password) async {
    try {
      await authInstance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (_, ex) {
      return ex.toString();
    }
  }
  
  @override
  Future<StringError> create(String name, String email, String password) async {
    try {
      UserCredential credential =  await authInstance.createUserWithEmailAndPassword(email: email, password: password);
      credential.user?.updateDisplayName(name);
    } on FirebaseAuthException catch (_, ex) {
      return ex.toString();
    }
  }
}