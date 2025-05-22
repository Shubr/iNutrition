import 'dart:developer';

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
          return 'Network error';
        case 'network-error':
          return 'Pelase check your internet connection';
        default:
          return 'Firebase Authentication error: ${e.message}--${e.code}';
      }
    }
  }
}

Future<String> logIn(String studentId, String password) async {
  var role = await getRole(studentId);

  if (role.isNotEmpty) {
    if (role == "nursingStudent") {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("nursingStudent")
          .doc(studentId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: data['eMail'], password: password);
          log("successfully signed in as nurse");
          return 'nursingStudent';
        }
      } else {
        return "Coun't find Student";
      }
    } else if (role == "exerciseStudent") {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("exerciseStudent")
          .doc(studentId)
          .get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: data['eMail'], password: password);
          log("succesfully signed in as student");
          return 'exerciseStudent';
        }
      } else {
        return "Coun't find Student";
      }
    }
  } else {
    return "";
  }
  return "Something went wrong";
}

Future<String> getRole(String studentId) async {
  try {
    QuerySnapshot<Map<String, dynamic>> nurseSnapshot =
        await FirebaseFirestore.instance.collection("nursingStudent").get();

    QuerySnapshot<Map<String, dynamic>> execStudentSnapshot =
        await FirebaseFirestore.instance.collection("exerciseStudent").get();
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
  return "";
}

Future signUpStudent(String eMail, String password) async {}
