import 'package:flutter/material.dart';
import 'widgets/calorie_card.dart';
import 'widgets/calorie_current_progress.dart';
import 'widgets/meal_entry_selector.dart';
import 'widgets/day_selector.dart';
import '../services/food_intake_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _dailyGoal = 2000; // Default value
  bool _loadingGoal = true;

  @override
  void initState() {
    super.initState();
    _loadDailyGoal();
  }

  Future<void> _loadDailyGoal() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('execStudent')
            .doc(user.email)
            .get();
        if (doc.exists && doc.data() != null) {
          setState(() {
            _dailyGoal = doc.data()!['dailyGoal'] ?? 2000;
            _loadingGoal = false;
          });
        } else {
          setState(() {
            _loadingGoal = false;
          });
        }
      } else {
        setState(() {
          _loadingGoal = false;
        });
      }
    } catch (e) {
      setState(() {
        _loadingGoal = false;
      });
    }
  }

  List<DateTime> _generatePast3Days() {
    final now = DateTime.now();
    return List.generate(3, (i) {
      final day = now.subtract(Duration(days: 1 - i));
      return DateTime(day.year, day.month, day.day);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yessy Teu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: const Icon(Icons.person_outline),
        actions: const [
          Icon(Icons.notifications_none),
          SizedBox(width: 10),
          Icon(Icons.settings_outlined),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _loadingGoal
                ? const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : StreamBuilder<List<FoodLogEntry>>(
                    stream: FoodIntakeService.todayFoodLogStream(),
                    builder: (context, snapshot) {
                      int currentCalories = 0;
                      if (snapshot.hasData) {
                        for (final entry in snapshot.data!) {
                          currentCalories += entry.calories * entry.quantity;
                        }
                      }
                      
                      double progress = _dailyGoal > 0 ? (currentCalories / _dailyGoal).clamp(0.0, 1.0) : 0.0;
                      int caloriesLeft = (_dailyGoal - currentCalories).clamp(0, _dailyGoal);
                      
                      return CalorieCurrentProgress(
                        progress: progress,
                        child: CalorieCard(
                          calsCurrent: "$currentCalories cals",
                          calsLeft: "$caloriesLeft calories left",
                        ),
                      );
                    },
                  ),
            const SizedBox(height: 28),
            DaySelector(
              days: _generatePast3Days(),
              selectedDay: DateTime.now(),
            ),
            const SizedBox(height: 28),
            const MealEntrySelector(),
          ],
        ),
      ),
    );
  }
}