import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodItem {
  final String name;
  final String quantity;
  final int calories;
  final String? details;

  FoodItem({
    required this.name,
    required this.quantity,
    required this.calories,
    this.details,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    final nutriments = json['nutriments'] ?? {};
    return FoodItem(
      name: json['product_name'] ?? 'Unnamed Food',
      quantity: json['quantity'] ?? 'N/A',
      calories: (nutriments['energy-kcal'] ?? 0).toInt(),
      details: json['ingredients_text'] ?? '',
    );
  }
}

class MealEntrySelector extends StatefulWidget {
  const MealEntrySelector({super.key});

  @override
  MealEntrySelectorState createState() => MealEntrySelectorState();
}

class MealEntrySelectorState extends State<MealEntrySelector> {
  int recommendedBreakfastCalories = 21;
  int recommendedLunchCalories = 21;
  int recommendedDinnerCalories = 21;

  String? expandedMeal;
  final TextEditingController _searchController = TextEditingController();

  List<FoodItem> searchResults = [];

  Future<void> searchFoods(String query) async {
    final url = Uri.parse(
        'https://world.openfoodfacts.org/cgi/search.pl?search_terms=$query&search_simple=1&action=process&json=1');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final products = data['products'] as List<dynamic>;
        final List<FoodItem> results = products
            .map((json) => FoodItem.fromJson(json))
            .where((item) => item.name.isNotEmpty)
            .toList();

        setState(() {
          searchResults = results;
        });
      } else {
        print('Failed to load foods: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching food: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    final meals = [
      {
        "key": "breakfast",
        "title": "Breakfast",
        "calories": recommendedBreakfastCalories,
        "icon": Icons.local_drink_outlined,
        "color": const Color.fromARGB(255, 255, 236, 194),
        "route": "/breakfastEntry"
      },
      {
        "key": "lunch",
        "title": "Lunch",
        "calories": recommendedLunchCalories,
        "icon": Icons.lunch_dining,
        "color": const Color.fromARGB(255, 201, 255, 178),
        "route": "/lunchEntry"
      },
      {
        "key": "dinner",
        "title": "Dinner",
        "calories": recommendedDinnerCalories,
        "icon": Icons.bakery_dining_outlined,
        "color": const Color.fromRGBO(190, 213, 255, 1),
        "route": "/dinnerEntry"
      },
    ];

    if (expandedMeal != null) {
      final meal = meals.firstWhere((m) => m["key"] == expandedMeal);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            _buildExpandedMeal(meal, isSmallScreen),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: meals.map((meal) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: _buildMealButton(
              context,
              "Add ${meal["title"]}",
              "Recommended ${meal["calories"]} calories",
              meal["route"] as String,
              meal["icon"] as IconData,
              meal["color"] as Color,
              isSmallScreen,
              meal["key"] as String,
            ),
          );
        }).toList(),
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
    String mealKey,
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
          setState(() {
            expandedMeal = mealKey;
            searchResults.clear();
            _searchController.clear();
          });
        },
      ),
    );
  }

  Widget _buildExpandedMeal(Map<String, dynamic> meal, bool isSmallScreen) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: meal["color"] as Color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${meal["title"]} Entry",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_up_outlined),
                onPressed: () {
                  setState(() {
                    expandedMeal = null;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Search Bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search for food...",
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
            onChanged: (value) {
              if (value.length > 2) {
                searchFoods(value);
              } else {
                setState(() => searchResults.clear());
              }
            },
          ),

          const SizedBox(height: 10),

          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, "/addCustomFood"),
            icon: const Icon(Icons.add),
            label: const Text("Add Custom Food"),
          ),

          const SizedBox(height: 12),

          if (searchResults.isEmpty)
            const Text("Search for food to see results.")
          else
            ...searchResults.map((food) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Expanded(child: Text(food.name)),
                      Text(food.quantity),
                      const SizedBox(width: 12),
                      Text("${food.calories} kcal"),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(food.details ?? "No ingredients listed."),
                    )
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}
