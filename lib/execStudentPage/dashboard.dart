import 'package:flutter/material.dart';
import 'package:inutrition/execStudentPage/progressBar.dart';
import 'package:inutrition/widgets/iWidget.dart';

class ExecStudentDashboard extends StatefulWidget {
  const ExecStudentDashboard({super.key});

  @override
  State<ExecStudentDashboard> createState() => _ExecStudentDashboardState();
}

class _ExecStudentDashboardState extends State<ExecStudentDashboard> {
  @override
  Widget build(BuildContext context) {
    return _dashbord();
  }

  Widget _dashbord() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text("Yessy Tau"),
          titleTextStyle: TextStyle(
              fontFamily: "Alex",
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
        body: Stack(children: [
          Column(
            spacing: 10,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(child: Progressbar())
            ],
          ),
          Positioned(
              right: 0,
              left: 0,
              bottom: 30,
              child: Center(
                child: iNavigator(),
              ))
        ]));
  }
}
