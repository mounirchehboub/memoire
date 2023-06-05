import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/UserModel.dart';

class Authentication {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Register with Email and Password
  //SignIn with Email and Password
  Future SignIn(String email, String password) async {
    try {
      var Result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = Result.user;
      return _userfromFirebaseUser(firebaseUser);
    } catch (error) {
      print(error.toString());
    }
  }

  //SignOut
  Future SignOut() async {
    await _firebaseAuth.signOut();
  }

  Users _userfromFirebaseUser(User? firebaseUser) {
    return firebaseUser != null
        ? Users(firebaseUser.uid, firebaseUser.emailVerified)
        : Users('', false);
  }

  Stream<Users> getUsers() {
    return _firebaseAuth.authStateChanges().map(_userfromFirebaseUser);
  }
}
