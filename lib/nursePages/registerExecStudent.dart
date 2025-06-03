import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inutrition/widgets/iWidget.dart';

class RegisterExecStudent extends StatefulWidget {
  const RegisterExecStudent({super.key});

  @override
  State<RegisterExecStudent> createState() => _RegisterExecStudentState();
}

class _RegisterExecStudentState extends State<RegisterExecStudent> {
  @override
  Widget build(BuildContext context) {
    return _registerPage();
  }

  Widget _registerPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "iNutrition",
          style: TextStyle(fontFamily: "Carter"),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, "/login");
            },
            icon: SvgPicture.asset("assets/icons/backicon.svg")),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            if (1 == 2)
              Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        "Add a new Student",
                        style: TextStyle(fontFamily: "Afacad", fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          spacing: 20,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            iTextField(
                                "First Name", false, TextEditingController()),
                            iTextField(
                                "Last Name", false, TextEditingController()),
                            iTextField(
                                "Student ID", false, TextEditingController()),
                            SizedBox(
                              height: 70,
                            ),
                            iButton("Next", () {})
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (2 == 1)
              Column(
                children: [
                  Center(
                    child: Text(
                      "Stats",
                      style: TextStyle(fontFamily: "Afacad", fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      spacing: 20,
                      children: [
                        iTextField("Age", false, TextEditingController()),
                        iTextField("Age", false, TextEditingController()),
                        iTextField(
                            "Height(cm)", false, TextEditingController()),
                        iTextField(
                            "Weight(kg)", false, TextEditingController()),
                        iTextField("Ethnicity", false, TextEditingController()),
                        iTextField("Exiting Media Condition", false,
                            TextEditingController()),
                        SizedBox(
                          height: 70,
                        ),
                        iButton("Next", () {})
                      ],
                    ),
                  ),
                ],
              ),
            if (3 == 1)
              Column(
                children: [
                  Center(
                    child: Text(
                      "Goal",
                      style: TextStyle(fontFamily: "Afacad", fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          spacing: 20,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            iTextField("Goal Weight(kg)", false,
                                TextEditingController()),
                            iTextField("Daily Calories Goal(cal)", false,
                                TextEditingController()),
                            SizedBox(
                              height: 70,
                            ),
                            iButton("Next", () {})
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            Column(
              children: [
                Center(
                  child: Text(
                    "Last Step",
                    style: TextStyle(fontFamily: "Afacad", fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        spacing: 20,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          iTextField("eMail", false, TextEditingController()),
                          iTextField("Password", true, TextEditingController()),
                          SizedBox(
                            height: 70,
                          ),
                          iButton("Register", () {})
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
