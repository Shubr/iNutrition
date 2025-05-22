import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inutrition/auth/auth.dart';
import 'package:inutrition/widgets/iWidget.dart';
import '../firebase_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var studentId = TextEditingController();
  var password = TextEditingController();

  String? errorMessage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "iNutrition",
            style: TextStyle(fontFamily: "Carter", fontSize: 25),
          ),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // vertical centering
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      iTextField("Student ID", false, studentId),
                      SizedBox(
                        height: 10,
                      ),
                      iTextField("password", true, password),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        errorMessage.toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 70),
                      iButton('Login', () async {
                        setState(() {
                          errorMessage = '';
                        });
                        if (studentId.text == "" || password.text == "") {
                          setState(() {
                            errorMessage = "Please fill in all fields";
                          });
                          return;
                        }
                        if (!mounted) {
                          return;
                        }
                        try {
                          String role =
                              await logIn(studentId.text, password.text);
                          if (role == "nursingStudent") {
                            print("loggin in as nurse...");
                            Navigator.pushReplacementNamed(
                                context, '/nursingDashboard');
                          } else if (role == 'exerciseStudent') {
                            Navigator.pushReplacementNamed(
                                context, '/execStudentDashboard');
                          } else {
                            setState(() {
                              errorMessage =
                                  "Sorry this Student isn't registered";
                            });
                          }
                        } catch (e) {
                          setState(() {
                            errorMessage = "ERROR: $e";
                          });
                        }
                      }),
                      const SizedBox(height: 20),
                      Align(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text(
                            "Don't have an account",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontFamily: "Afacad"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
