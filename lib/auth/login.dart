import 'package:flutter/material.dart';
import 'package:inutrition/widgets/iWidget.dart';
import '../firebase_options.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var eMail = TextEditingController();
    var password = TextEditingController();
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
                      iTextField("eMail", false, TextEditingController()),
                      SizedBox(
                        height: 10,
                      ),
                      iTextField("password", true, TextEditingController()),
                      // Align(
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       print("click");
                      //     },
                      //     child: const Text(
                      //       "Forgot Password?",
                      //       style: TextStyle(
                      //           color: Colors.grey, fontFamily: "Afacad"),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 30),
                      iButton('Login', () {}),
                      const SizedBox(height: 10),
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
