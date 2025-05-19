import 'package:flutter/widgets.dart';
import 'package:inutrition/model/data_model.dart';
import 'package:inutrition/widgets/iWidget.dart';
import 'package:inutrition/auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  List<String> studentList = [];

  Future<List<String>> getAllStudentId() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection("nurseDb").get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in querySnapshot.docs) {
        studentList.add(doc.id);
      }
    } catch (e) {
      print(e);
    }
    return studentList;
  }

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
    getAllStudentId();
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
                                    } else if (studentList
                                        .contains(studentId.text)) {
                                      fieldError = "StudentId already exists";
                                    } else {
                                      nextStep();
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
                                      nextStep();
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
                                    NurseModel nurseInfo = new NurseModel(
                                        studentId.text,
                                        firstName.text,
                                        lastName.text,
                                        college.text,
                                        course.text,
                                        eMail.text);
                                    var info = nurseInfo.conver();
                                    String? returnVal = await signUpNurse(
                                        eMail.text, password.text, info);
                                    if (returnVal == "") {
                                      setState(() {
                                        fieldError = "Successfull";
                                      });
                                    } else {
                                      print("$returnVal");
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
