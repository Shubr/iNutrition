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
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedDate,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 6),
                Text(
                  widget.calsCurrent,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  widget.calsLeft,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
