import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inutrition/auth/auth.dart';
import 'package:inutrition/model/data_model.dart';
import 'package:inutrition/widgets/iWidget.dart';

List<String> studentList = [];
var error = "";

Future<List<String>> getStudent() async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("execStudent").get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      studentList.add(doc.id);
    }
  } catch (err) {
    print(err);
  }
  return studentList;
}

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

  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var studentId = TextEditingController();
  var age = TextEditingController();
  var gender = "";
  var height = TextEditingController();
  var weight = TextEditingController();
  var ethnicity = TextEditingController();
  var medical = TextEditingController();
  var goalWeight = TextEditingController();
  var dailyCalGoal = TextEditingController();
  var eMail = TextEditingController();
  var password = TextEditingController();

  int currentStep = 0;

  void _back() {
    error = "";
    if (currentStep != 0) {
      setState(() {
        currentStep -= 1;
      });
    } else {
      Navigator.pushReplacementNamed(context, "/nursingDashboard");
    }
  }

  void _next() {
    error = "";
    if (currentStep < 3) {
      setState(() {
        currentStep += 1;
      });
    }
  }

  Widget _registerPage() {
    getStudent();
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
              _back();
            },
            icon: SvgPicture.asset("assets/icons/backicon.svg")),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            if (currentStep == 0)
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
                            iTextField("First Name", false, firstName),
                            iTextField("Last Name", false, lastName),
                            iTextField("Student ID", false, studentId),
                            Text(
                              error,
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            iButton("Next", () {
                              if (studentId.text == "" ||
                                  firstName.text == "" ||
                                  lastName.text == "") {
                                setState(() {
                                  error = "Please fill in all fields";
                                });
                              } else if (studentList.contains(studentId.text)) {
                                setState(() {
                                  error = "Student with this ID already exists";
                                });
                              } else {
                                _next();
                              }
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (currentStep == 1)
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
                        iTextField("Age", false, age),
                        iRadio(
                            category: "Gender",
                            title1: "Male",
                            title2: "Female",
                            selected: gender,
                            onChange: (value) {
                              setState(() {
                                gender = value;
                              });
                            }),
                        iTextField("Height(cm)", false, height),
                        iTextField("Weight(kg)", false, weight),
                        iTextField("Ethnicity", false, ethnicity),
                        iTextField("Exiting Medical Condition", false, medical),
                        iButton("Next", () {
                          if (age.text == "" ||
                              gender == "" ||
                              height.text == "" ||
                              weight.text == "" ||
                              ethnicity.text == "") {
                            setState(() {
                              error = "Please fill in all fields";
                            });
                          } else {
                            _next();
                          }
                        })
                      ],
                    ),
                  ),
                ],
              ),
            if (currentStep == 2)
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
                            iTextField("Goal Weight(kg)", false, goalWeight),
                            iTextField("Daily Calories Goal(cal)", false,
                                dailyCalGoal),
                            SizedBox(
                              height: 70,
                            ),
                            iButton("Next", () {
                              if (goalWeight.text == "" ||
                                  dailyCalGoal.text == "") {
                                setState(() {
                                  error = "Please fill in all fields";
                                });
                              } else {
                                _next();
                              }
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (currentStep == 3)
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
                            iTextField("eMail", false, eMail),
                            iTextField("Password", true, password),
                            SizedBox(
                              height: 70,
                            ),
                            iButton("Register", () async {
                              if (eMail.text != "" && password.text != "") {
                                ExecStudentModel execStudent = ExecStudentModel(
                                    studentId.text,
                                    firstName.text,
                                    lastName.text,
                                    age.text,
                                    gender,
                                    height.text,
                                    weight.text,
                                    ethnicity.text,
                                    medical.text,
                                    goalWeight.text,
                                    dailyCalGoal.text,
                                    "Antony Tau",
                                    eMail.text);
                                var info = execStudent.conver();
                                signUpStudent(eMail.text, password.text, info);
                              } else {
                                setState(() {
                                  error = "Please fill in all fields";
                                });
                              }
                            })
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
