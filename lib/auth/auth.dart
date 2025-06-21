import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

var fireStore = FirebaseFirestore.instance;
var fireAuth = FirebaseAuth.instance;

Future<String?> signUpNurse(
    String eMail, String password, Map<String, dynamic> nurseDetail) async {
  try {
    var studentId = nurseDetail["studentId"];
    await fireAuth.createUserWithEmailAndPassword(
        email: eMail, password: password);
    await fireStore
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
      default:
        return 'Something went wrong.';
    }
  }
}

Future<String> getRole(String studentId) async {
  try {
    QuerySnapshot<Map<String, dynamic>> nurseSnapshot =
        await fireStore.collection("nursingStudent").get();

    QuerySnapshot<Map<String, dynamic>> execStudentSnapshot =
        await fireStore.collection("exerciseStudent").get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in nurseSnapshot.docs) {
      if (doc.id == studentId) {
        return "nursingStudent";
      }
    }
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in execStudentSnapshot.docs) {
      if (doc.id == studentId) {
        return "exerciseStudent";
      }
    }
  } catch (e) {
    log("Error: $e");
  }
  return "Student dosen't exist.";
}

Future signUpStudent(String eMail, String password,
    Map<String, dynamic> execStudentDetail) async {
  try {
    var studentId = execStudentDetail['studentId'];
    fireAuth.createUserWithEmailAndPassword(email: eMail, password: password);
    fireStore.collection("execStudent").doc(studentId).set(execStudentDetail);
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
