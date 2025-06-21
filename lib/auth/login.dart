import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inutrition/auth/auth.dart';
import 'package:inutrition/widgets/iWidget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../firebase_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var eMail = TextEditingController();
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
                      iTextField("eMail", false, eMail),
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
                        if (eMail.text != '' && password.text != "") {
                          showDialog(
                              context: context,
                              builder: (context) => Center(
                                    child: LoadingAnimationWidget.waveDots(
                                        color: Colors.black, size: 50),
                                  ));
                          var result = await logIn(eMail.text, password.text);
                          Navigator.pop(context);
                          if (result) {
                            Navigator.pushReplacementNamed(
                                context, '/nursingDashboard');
                          } else {
                            setState(() {
                              errorMessage = result;
                            });
                          }
                        } else {
                          setState(() {
                            errorMessage = "Please fill in all feilds.";
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
