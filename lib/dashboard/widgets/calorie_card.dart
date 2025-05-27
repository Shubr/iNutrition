import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalorieCard extends StatefulWidget {
  final String calsCurrent;
  final String calsLeft;

  const CalorieCard({
    super.key,
    required this.calsCurrent,
    required this.calsLeft,
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
    formattedDate = DateFormat('EEE, MMM d').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
child: Container(
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        blurRadius: 12,
        spreadRadius: 2,
        offset: const Offset(0, 8),
      ),
    ],
  ),
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          formattedDate,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.calsCurrent,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          widget.calsLeft,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
              ],
            ),
          )
        )
      )
    ;
  }
}
