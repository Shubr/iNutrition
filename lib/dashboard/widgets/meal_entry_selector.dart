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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          _buildMealButton(
            context,
            "Add Breakfast",
            "Recommended $recommendedBreakfastCalories calories",
            "/breakfastEntry",
            Icons.local_drink_outlined,
            const Color.fromARGB(255, 255, 236, 194),
            isSmallScreen,
          ),
          const SizedBox(height: 15),
          _buildMealButton(
            context,
            "Add Lunch",
            "Recommended $recommendedLunchCalories calories",
            "/lunchEntry",
            Icons.lunch_dining,
            const Color.fromARGB(255, 201, 255, 178),
            isSmallScreen,
          ),
          const SizedBox(height: 15),
          _buildMealButton(
            context,
            "Add Dinner",
            "Recommended $recommendedDinnerCalories calories",
            "/dinnerEntry",
            Icons.bakery_dining_outlined,
            const Color.fromRGBO(190, 213, 255, 1),
            isSmallScreen,
          ),
        ],
      ),
    );
  }

  Widget _buildMealButton(
    BuildContext context,
    String title,
    String recommendation,
    String route,
    IconData icon,
    Color buttonColor,
    bool isSmallScreen,
  ) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black12),
          ),
        ),
        icon: Icon(icon, size: isSmallScreen ? 36 : 48),
        label: Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                recommendation,
                style: TextStyle(
                  fontSize: isSmallScreen ? 13 : 16,
                  fontWeight: FontWeight.w300,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
