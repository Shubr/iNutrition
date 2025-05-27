import 'package:flutter/material.dart';
import 'widgets/calorie_card.dart';
import 'widgets/calorie_current_progress.dart';
import 'widgets/meal_entry_selector.dart';
import 'widgets/day_selector.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final double _calorieProgress = 0.65;

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
          CalorieCurrentProgress(
            progress: _calorieProgress,
            child: const CalorieCard(
              calsCurrent: "1,750 cals",
              calsLeft: "250 calories left",
            ),
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