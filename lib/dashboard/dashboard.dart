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
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        leading: const Icon(Icons.person_3_outlined),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20),
        child: Center(
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
              const SizedBox(height: 30),
              // DaySelector(
              //   days: _generatePast3Days(),
              //   selectedDay: DateTime.now(),
              // ),
              const SizedBox(height: 30),
              const MealEntrySelector(),
            ],
          ),
        ),
      ),
    );
  }
}
