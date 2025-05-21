import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

Future<String?> signUpNurse(
    String eMail, String password, Map<String, dynamic> nurseDetail) async {
  try {
    var studentId = nurseDetail["studentId"];
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: eMail, password: password);
    await FirebaseFirestore.instance
        .collection("nursingStudent")
        .doc(studentId)
        .set(nurseDetail);
    return "Successfully added to firestore";
  } catch (e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'email-already-in-use':
          return 'An account already exists for that email.';
        case 'channel-error': // Check for the network error code here
          return 'Please check your internet connection.';
        default:
          return 'Firebase Authentication error: ${e.message}--${e.code}';
      }
    }
  }
}

Future<String?> logIn(String eMail, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: eMail, password: password);
  } catch (e) {}
}

Future signUpStudent(String eMail, String password) async {}
