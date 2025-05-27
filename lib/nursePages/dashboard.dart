import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/icons/sign_outIcon.svg",
                ))
          ],
          centerTitle: false,
          title: Text("Antony Lau"),
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 20,
              fontFamily: "Alex"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [iSmallButton("ADD", () {})],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 20,
                      children: [
                        iStudentCard("Shubham Rangra", 40, () {}),
                        iStudentCard("Antonio Munro", 90, () {}),
                        iStudentCard("Jessey Tau", 80, () {}),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
