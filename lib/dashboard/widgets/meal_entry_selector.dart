import 'package:flutter/material.dart';

class MealEntrySelector extends StatefulWidget {
  const MealEntrySelector({super.key});

  @override
  MealEntrySelectorState createState() => MealEntrySelectorState();
}

class MealEntrySelectorState extends State<MealEntrySelector> {
  int recommendedBreakfastCalories = 21;
  int recommendedLunchCalories = 21;
  int recommendedDinnerCalories = 21;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMealButton(
          context,
          "Add Breakfast",
          "Recommended $recommendedBreakfastCalories calories",
          "/breakfastEntry",
          Icons.local_drink_outlined,
          const Color.fromARGB(255, 255, 236, 194), // Breakfast button color
        ),
        const SizedBox(height: 15),
        _buildMealButton(
          context,
          "Add Lunch",
          "Recommended $recommendedLunchCalories calories",
          "/lunchEntry",
          Icons.lunch_dining,
          const Color.fromARGB(255, 201, 255, 178), // Lunch button color
        ),
        const SizedBox(height: 15),
        _buildMealButton(
          context,
          "Add Dinner",
          "Recommended $recommendedDinnerCalories calories",
          "/dinnerEntry",
          Icons.bakery_dining_outlined,
          const Color.fromRGBO(190, 213, 255, 1), // Dinner button color
        ),
      ],
    );
  }

  Widget _buildMealButton(
    BuildContext context,
    String title,
    String recommendation,
    String route,
    IconData icon,
    Color buttonColor,
  ) {
    return SizedBox(
      width: 300,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: Colors.black12),
          ),
        ),
        icon: Icon(icon, size: 50),
        label: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w500)),
            const SizedBox(height: 1),
            Text(recommendation, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
          ],
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
