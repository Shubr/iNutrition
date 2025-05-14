import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inutrition/dashboard/dashboard.dart';
import 'package:inutrition/auth/login.dart';
import 'package:inutrition/auth/register.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: RegisterPage());
  }
}
