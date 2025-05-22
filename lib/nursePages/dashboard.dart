import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inutrition/widgets/iWidget.dart';

class NurseingDashboard extends StatefulWidget {
  const NurseingDashboard({super.key});

  @override
  State<NurseingDashboard> createState() => _NurseingDashboardState();
}

class _NurseingDashboardState extends State<NurseingDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Antony Lau"),
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 20,
            fontFamily: "Alex"),
      ),
    );
  }
}
