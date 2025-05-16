import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future signUpNurse(String eMail, String password) async {
  await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: eMail, password: password);
}

Future signUpStudent(String eMail, String password) async{
  
}

Future logIn(String eMail, String password) async {
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: eMail, password: password);
}
