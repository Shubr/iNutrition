import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NurseingDashboard extends StatefulWidget {
  const NurseingDashboard({super.key});

  @override
  State<NurseingDashboard> createState() => _NurseingDashboardState();
}

class _NurseingDashboardState extends State<NurseingDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Hello Doc"),
    );
  }
}
