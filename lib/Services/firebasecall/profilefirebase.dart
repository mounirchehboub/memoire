import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/ProfileModel.dart';

class FirebaseCalls {
  final String uid;
  FirebaseCalls({required this.uid});
  CollectionReference profiles =
      FirebaseFirestore.instance.collection("Profiles");

  Future updateProfile(String firstName, String lastName, String email) async {
    return profiles.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'userId': uid,
    });
  }

  //A function to retrieve profile data
  Future<ProfileModel> getProfileData() async {
    DocumentSnapshot querySnapshot = await profiles.doc(uid).get();
    if (querySnapshot.exists) {
      var data = querySnapshot.data() as Map<String, dynamic>;
      ProfileModel profile = ProfileModel.fromJson(data);
      return profile;
    } else {
      return ProfileModel(firstName: '', lastName: '', email: '', userId: '');
    }
  }
}
