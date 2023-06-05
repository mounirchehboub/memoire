import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monirakrem/Services/SharedPrefrences/SharedPrefrencesService.dart';
import 'package:provider/provider.dart';

import '../Services/firebasecall/profilefirebase.dart';
import '../models/UserModel.dart';

part 'Auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialAuthState());
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future SignIn(String email, String password) async {
    emit(LoadingSignInState());
    try {
      UserCredential Result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      User? firebaseUser = Result.user;

      emit(SignInSuccessfuly(_userfromFirebaseUser(firebaseUser)));
    } catch (error) {
      emit(ErrorSignInState(error.toString()));
    }
  }

  Future<void> SignOut() async {
    try {
      emit(LoadingSignOutStat());
      await _firebaseAuth.signOut();
      SharedPref sharedPref = await SharedPref.getInstance();
      await sharedPref.clearProfile();
      emit(SignOutSuccessful());
    } catch (error) {
      emit(FailedSignOut(errorMessage: error.toString()));
    }
  }

  Future SignUp(
      String firstName, String lastName, String email, String password) async {
    emit(LoadingRegesteringState());
    try {
      var Result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = Result.user;
      await FirebaseCalls(uid: firebaseUser!.uid)
          .updateProfile(firstName, lastName, email);
      emit(UserRegisteredState());
    } catch (error) {
      emit(ErrorRegesteringState(error.toString()));
    }
  }

  Future<void> recovery({required String email}) async {
    try {
      emit(LoadingReset());
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      emit(ResetSuccess());
    } catch (error) {
      emit(ErrorResetState(error.toString()));
    }
  }

  Users _userfromFirebaseUser(User? firebaseUser) {
    return firebaseUser != null
        ? Users(firebaseUser.uid, firebaseUser.emailVerified)
        : Users('', false);
  }

  Stream<Users> get user {
    return _firebaseAuth.authStateChanges().map(_userfromFirebaseUser);
  }
}
