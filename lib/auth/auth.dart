import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var fireStore = FirebaseFirestore.instance;
var fireAuth = FirebaseAuth.instance;

Future signUpNurse(
    String eMail, String password, Map<String, dynamic> nurseDetail) async {
  try {
    await fireAuth.createUserWithEmailAndPassword(
        email: eMail, password: password);
    await fireStore.collection("nursingStudent").doc(eMail).set(nurseDetail);
    return true;
  } catch (e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'email-already-in-use':
          return 'An account already exists for that email.';
        case 'channel-error':
          return 'unable to connect to the cloud';
        case 'network-error':
          return 'Pelase check your internet connection';
        default:
          return 'Firebase Authentication error: ${e.message}--${e.code}';
      }
    }
  }
}

Future logIn(String eMail, String password) async {
  try {
    await fireAuth.signInWithEmailAndPassword(email: eMail, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'user-not-found':
        return 'User Not Found';
      case 'wrong-password':
        return 'Incorrect Password';
      case "invalid-credential":
        return 'Incorrect eMail/Password';
      default:
        return 'Something went wrong.';
    }
  }
}

Future<String> getRole(String eMail) async {
  final nurseQuery = await fireStore
      .collection("nursingStudent")
      .where("eMail", isEqualTo: eMail)
      .get();

  if (nurseQuery.docs.isNotEmpty) {
    return 'nursingStudent';
  }

  final execQuery = await fireStore
      .collection("execStudent")
      .where("eMail", isEqualTo: eMail)
      .get();

  if (execQuery.docs.isNotEmpty) {
    return 'execStudent';
  }

  return 'none';
}

Future signUpStudent(String eMail, String password,
    Map<String, dynamic> execStudentDetail) async {
  try {
    fireAuth.createUserWithEmailAndPassword(email: eMail, password: password);
    fireStore.collection("execStudent").doc(eMail).set(execStudentDetail);
    return true;
  } catch (e) {
    log(e.hashCode.toString());
    return false;
  }
}

Future signOut() async {
  try {
    await fireAuth.signOut();
  } catch (e) {
    log(e.toString());
  }
}
