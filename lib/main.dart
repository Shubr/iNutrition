import 'package:flutter/material.dart';
import 'package:inutrition/dashboard/dashboard.dart';
import 'package:inutrition/login.dart';
import 'package:inutrition/register.dart';
import 'package:inutrition/stats.dart';

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
    return const Scaffold(

      body: StatsPage(),
    );
  }
}
