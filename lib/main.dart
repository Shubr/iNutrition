import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inutrition/auth/login.dart';
import 'package:inutrition/auth/register.dart';
import 'package:inutrition/firebase_options.dart';
import 'package:inutrition/nursePages/dashboard.dart';
import 'package:inutrition/dashboard/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() {
    print("complete");
  });
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (content) => const RegisterPage(),
        '/nursingDashboard': (context) => NurseingDashboard(),
        '/execStudentDashboard': (context) => DashboardPage()
      },
    );
  }
}
