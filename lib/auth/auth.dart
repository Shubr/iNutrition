import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

Future<String?> signUpNurse(String eMail, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: eMail, password: password);
    return "";
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
    } else if (e is PlatformException) {
      return 'A platform error occurred: ${e.message}';
    } else {
      return 'An unexpected error occurred. Please try again later.';
    }
  }
}

Future signUpStudent(String eMail, String password) async {}

Future logIn(String eMail, String password) async {
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: eMail, password: password);
}
