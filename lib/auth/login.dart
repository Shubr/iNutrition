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
  @override
  Widget build(BuildContext context) {
    var studentId = TextEditingController();
    var password = TextEditingController();

    String? errorMessage = "";

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
                      iButton('Login', () {
                        print("Signing");
                        logIn(studentId.text, password.text);
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
