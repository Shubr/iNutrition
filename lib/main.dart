import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inutrition/auth/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp().whenComplete(() {
      print("Complete");
    });
    return const Scaffold(body: RegisterPage());
  }
}
