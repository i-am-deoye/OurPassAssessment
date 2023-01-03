


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

mixin BaseRemoteRepository {
  final FirebaseAuth authInstance = FirebaseAuth.instance;
}
