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
  late double _progress;

  @override
  void initState() {
    super.initState();
    _progress = widget.progress;
  }

  @override
  void didUpdateWidget(covariant CalorieCurrentProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      setState(() {
        _progress = widget.progress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double size = constraints.maxWidth * 0.6;
        final double innerSize = size * 0.65;

        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: _progress,
                  strokeWidth: 10,
                  backgroundColor: const Color.fromARGB(30, 224, 224, 224),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 113, 246, 144),
                  ),
                ),
              ),
              SizedBox(
                width: innerSize,
                height: innerSize,
                child: widget.child,
              ),
            ],
          ),
        );
      },
    );
  }
}
