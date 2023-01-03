

import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourpass_assessment/core/data/base.remote.repository.dart';

class IAuthRepository {
  Future signIn(String email, String password) async {}
  Future create(String name, String email, String password) async {}
}


class AuthRepository with BaseRemoteRepository implements IAuthRepository {

  @override
  Future signIn(String email, String password) async {
    return await authInstance.signInWithEmailAndPassword(email: email, password: password);
  }
  
  @override
  Future create(String name, String email, String password) async {
    try {
      UserCredential credential =  await authInstance.createUserWithEmailAndPassword(email: email, password: password);
      credential.user?.updateDisplayName(name);
    } on FirebaseAuthException catch (_, ex) {

    }
  }
}