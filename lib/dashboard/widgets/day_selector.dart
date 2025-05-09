import 'package:flutter/material.dart';

class DaySelector extends StatefulWidget {
  const DaySelector({super.key});

  @override
  State<DaySelector> createState() => DaySelectorState();
}

class DaySelectorState extends State<DaySelector> {
  int _selectedIndex = 0;

  final List<Map<String, String>> days = [
    {"day": "Sat", "date": "15"},
    {"day": "Sun", "date": "16"},
    {"day": "Mon", "date": "17"},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.chevron_left, size: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(days.length, (index) {
            final day = days[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: _buildDay(day["day"]!, day["date"]!, isSelected: index == _selectedIndex),
              ),
            );
          }),
        ),
        const Icon(Icons.chevron_right, size: 30),
      ],
    );
  }

  Widget _buildDay(String dayName, String date, {bool isSelected = false}) {
    if (isSelected) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 84, 84),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              children: [
                Text(
                  dayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    date,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            dayName,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(date),
        ],
      );
    }
  }
}
