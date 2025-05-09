import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalorieCard extends StatefulWidget {
  final String calsCurrent;
  final String calsLeft;

  const CalorieCard({
    super.key,
    required this.calsCurrent,
    required this.calsLeft, required DateTime Function() dateToday,
  });

  @override
  State<CalorieCard> createState() => _CalorieCardState();
}

class _CalorieCardState extends State<CalorieCard> {
  late final String formattedDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    formattedDate = DateFormat('EEE, MMM d').format(now); // e.g., "Wed, May 8"
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromARGB(0, 0, 0, 0), width: 2),
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: "Afacad",
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.calsCurrent,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Afacad",
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.calsLeft,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: "Afacad",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
