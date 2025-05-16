import 'package:flutter/widgets.dart';
import 'package:inutrition/widgets/iWidget.dart';
import 'package:inutrition/auth/auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var studentId = TextEditingController();
  var college = TextEditingController();
  var course = TextEditingController();
  var eMail = TextEditingController();
  var password = TextEditingController();

  String? fieldError = "";
  int currentStep = 0;
  void nextStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep++;
        fieldError = "";
      });
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
        fieldError = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/backicon.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          onPressed: () {
            if (currentStep == 0) {}
            if (currentStep > 0) {
              setState(() {
                currentStep--;
              });
            } else {}
          },
        ),
        title: const Text(
          "iNutrition",
          style: TextStyle(fontFamily: "Carter"),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, container) {
          return (SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: container.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (currentStep == 0)
                          const Text("Tell us about yourself",
                              style: TextStyle(
                                  fontFamily: "afacad", fontSize: 20)),
                        if (currentStep == 1)
                          const Text(
                            "How about your College",
                            style:
                                TextStyle(fontFamily: "afacad", fontSize: 20),
                          ),
                        if (currentStep == 2)
                          const Text("Last step",
                              style: TextStyle(
                                  fontFamily: "afacad", fontSize: 20)),
                        if (currentStep == 0)
                          Expanded(
                              child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                iTextField("First Name", false, firstName),
                                const SizedBox(
                                  height: 10,
                                ),
                                iTextField("Last Name", false, lastName),
                                const SizedBox(
                                  height: 10,
                                ),
                                iTextField("StudentId", false, studentId),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  fieldError.toString(),
                                  style: TextStyle(color: Colors.red),
                                ),
                                const SizedBox(height: 70),
                                iButton("Next", () {
                                  setState(() {
                                    if (firstName.text == "" ||
                                        lastName.text == "" ||
                                        studentId.text == "") {
                                      fieldError = "Please enter all fields";
                                    } else {
                                      currentStep++;
                                    }
                                  });
                                })
                              ],
                            ),
                          )),
                        if (currentStep == 1)
                          Expanded(
                              child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                iTextField("College", false, college),
                                const SizedBox(
                                  height: 10,
                                ),
                                iTextField("Course", false, course),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  fieldError.toString(),
                                  style: TextStyle(color: Colors.red),
                                ),
                                const SizedBox(height: 70),
                                iButton("Next", () {
                                  if (course.text == "") {}
                                  setState(() {
                                    if (course.text == "" ||
                                        college.text == "") {
                                      fieldError = "Please enter all fields";
                                    } else {
                                      currentStep++;
                                    }
                                  });
                                })
                              ],
                            ),
                          )),
                        if (currentStep == 2)
                          Expanded(
                              child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                iTextField("eMail", false, eMail),
                                const SizedBox(
                                  height: 10,
                                ),
                                iTextField("Password", true, password),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  fieldError.toString(),
                                  style: TextStyle(color: Colors.red),
                                ),
                                const SizedBox(
                                  height: 70,
                                ),
                                iButton("Register", () async {
                                  if (eMail.text != "" || password.text != "") {
                                    String? returnVal = await signUpNurse(
                                        eMail.text, password.text);
                                    if (returnVal == "") {
                                      setState(() {
                                        fieldError = "Successfull";
                                      });
                                    } else {
                                      print("A$returnVal");
                                      setState(() {
                                        fieldError = returnVal;
                                      });
                                    }
                                  } else {
                                    fieldError = "Please fill all fields";
                                  }
                                })
                              ],
                            ),
                          ))
                      ],
                    ),
                  ),
                )),
          ));
        },
      ),
    );
  }
}
