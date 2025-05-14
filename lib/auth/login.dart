import 'package:flutter/material.dart';
import '../firebase_options.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "eMail",
                          style: TextStyle(
                            fontFamily: "Afacad",
                            fontSize: 18,
                            color: Color.fromARGB(255, 157, 157, 157),
                          ),
                        ),
                      ),
                      _buildTextField(),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontFamily: "Afacad",
                            fontSize: 18,
                            color: Color.fromARGB(255, 157, 157, 157),
                          ),
                        ),
                      ),
                      _buildTextField(),
                      Align(
                        child: GestureDetector(
                          onTap: () {
                            print("click");
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.grey, fontFamily: "Afacad"),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 160,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.red,
                            elevation: 8,
                            side:
                                const BorderSide(color: Colors.white, width: 4),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontFamily: "afacad",
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        child: GestureDetector(
                          onTap: () {
                            print("click");
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

Widget _buildTextField() {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: const Color.fromARGB(255, 223, 223, 223),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 104, 104, 104).withOpacity(0.1),
          blurRadius: 5,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: const TextField(
      cursorColor: Colors.black,
      style: TextStyle(height: 2, fontFamily: "Afacad", fontSize: 20),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: InputBorder.none,
      ),
    ),
  );
}
