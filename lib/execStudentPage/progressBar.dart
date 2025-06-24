import 'dart:math';
import 'package:flutter/material.dart';

class Progressbar extends StatefulWidget {
  final int currentCalories;
  final int dailyGoal;

  const Progressbar({
    super.key,
    required this.currentCalories,
    required this.dailyGoal,
  });

  @override
  State<Progressbar> createState() => _ProgressbarState();
}

class _ProgressbarState extends State<Progressbar> {
  double get progress {
    if (widget.dailyGoal <= 0) return 0.0;
    return (widget.currentCalories / widget.dailyGoal).clamp(0.0, 1.0);
  }

  int get caloriesLeft {
    return (widget.dailyGoal - widget.currentCalories).clamp(0, widget.dailyGoal);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      height: 210,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(200, 200),
            painter: GradientCirclePainter(progress),
          ),
          // Inner white circle to create spacing
          Container(
            width: 140,
            height: 140,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          // Inner circle with text
          Container(
            width: 140,
            height: 140,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 211, 211, 211),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                )
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${widget.currentCalories}",
                      style: const TextStyle(
                          fontFamily: "Avent",
                          fontSize: 50,
                          color: Color.fromARGB(255, 0, 161, 255)),
                    ),
                    const Text(
                      "cal",
                      style: TextStyle(
                          fontFamily: "Avent",
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 161, 255)),
                    ),
                  ],
                ),
                Text(
                  "${caloriesLeft}cal left",
                  style: const TextStyle(
                      fontFamily: "Afacad",
                      color: Color.fromARGB(255, 122, 122, 122),
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GradientCirclePainter extends CustomPainter {
  final double progress;

  GradientCirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 20.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width + strokeWidth) / 2.2;

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Gradient shader (top to bottom)
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(255, 200, 235, 255),
        Color.fromARGB(255, 70, 187, 255),
        Color.fromARGB(255, 0, 161, 255),
      ],
    );

    final rect = Rect.fromCircle(center: center, radius: radius);
    final foregroundPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from top
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
