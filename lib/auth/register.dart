import 'package:inutrition/widgets/iWidget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int currentStep = 0;
  void nextStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
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
                                iTextField("First Name", false),
                                const SizedBox(
                                  height: 10,
                                ),
                                iTextField("Last Name", false),
                                const SizedBox(
                                  height: 10,
                                ),
                                iTextField("StudentId", false),
                                const SizedBox(height: 80),
                                iButton("Next", () {
                                  setState(() {
                                    currentStep++;
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
                                iTextField("College", false),
                                const SizedBox(
                                  height: 10,
                                ),
                                iTextField("Course", false),
                                const SizedBox(
                                  height: 80,
                                ),
                                iButton("Next", () {
                                  setState(() {
                                    currentStep++;
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
                                iTextField("eMail", false),
                                const SizedBox(
                                  height: 10,
                                ),
                                iTextField("Password", true),
                                const SizedBox(
                                  height: 80,
                                ),
                                iButton("Register", () {
                                  setState(() {});
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
