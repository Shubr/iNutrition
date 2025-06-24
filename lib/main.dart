import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inutrition/auth/login.dart';
import 'package:inutrition/auth/register.dart';
import 'package:inutrition/execStudentPage/dashboard.dart';
import 'package:inutrition/dashboard/widgets/meal_entry_screen.dart';

import 'package:inutrition/firebase_options.dart';
import 'package:inutrition/nursePages/dashboard.dart';
import 'package:inutrition/dashboard/dashboard.dart';
import 'package:inutrition/nursePages/registerExecStudent.dart';
import 'package:inutrition/execStudentPage/user_profile_page.dart';
import 'package:inutrition/widgets/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BottomNavBar(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (content) => const RegisterPage(),
        '/nursingDashboard': (context) => NurseingDashboard(),
        '/execStudentDashboard': (context) => ExecStudentDashboard(),
        '/registerExecStudent': (context) => RegisterExecStudent(),
        '/breakfastEntry': (context) => const MealEntryScreen(mealType: 'breakfast'),
        '/lunchEntry': (context) => const MealEntryScreen(mealType: 'lunch'),
        '/dinnerEntry': (context) => const MealEntryScreen(mealType: 'dinner'),
        '/userProfile': (context) => const UserProfilePage(),
      },
    );
  }
}
