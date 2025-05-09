import 'package:flutter/material.dart';

class CalorieCurrentProgress extends StatefulWidget {
  final Widget child;
  final double progress;

  const CalorieCurrentProgress({
    super.key,
    required this.child,
    required this.progress,
  });

  @override
  State<CalorieCurrentProgress> createState() => _CalorieCurrentProgressState();
}

class _CalorieCurrentProgressState extends State<CalorieCurrentProgress> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: CircularProgressIndicator(
            value: widget.progress,
            strokeWidth: 10,
            backgroundColor: const Color.fromARGB(0, 224, 224, 224),
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 113, 246, 144),
            ),
          ),
        ),
        SizedBox(
          width: 130,
          height: 130,
          child: widget.child,
        ),
      ],
    );
  }
}
