import 'package:flutter/material.dart';
import 'widgets/calorie_card.dart';
import 'widgets/calorie_current_progress.dart';
import 'widgets/day_selector.dart';
import 'widgets/meal_entry_selector.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final double _calorieProgress = 0.65;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yessy Teu',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        leading: const Icon(Icons.person_3_outlined),
        actions: [
          IconButton(
              onPressed: () => {}, icon: const Icon(Icons.notifications_none_outlined)),
          IconButton(
              onPressed: () => {}, icon: const Icon(Icons.settings_outlined)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CalorieCurrentProgress(
            progress: _calorieProgress,
            child: const CalorieCard(
              dateToday: DateTime.now,
              calsCurrent: "1,750 cals",
              calsLeft: "250 calories left",
            ),
          ),
          const SizedBox(height: 30),
          const DaySelector(),
          const SizedBox(height: 30),
          const MealEntrySelector(),
        ],
      ),
    );
  }
}
