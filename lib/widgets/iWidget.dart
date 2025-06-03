import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget iTextField(String name, bool isPassword, TextEditingController text) {
  return Container(
    constraints: BoxConstraints(maxWidth: 500),
    child: Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(name,
              style: const TextStyle(
                  fontSize: 15, color: Colors.grey, fontFamily: "Afacad")),
        ),
        Container(
            // margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color.fromARGB(255, 223, 223, 223),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 240, 240, 240),
                  blurRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: text,
              obscureText: isPassword,
              cursorColor: Colors.black,
              style: const TextStyle(
                  decorationThickness: 0,
                  height: 1.5,
                  fontFamily: "Afacad",
                  fontSize: 20),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                border: InputBorder.none,
              ),
            )),
      ],
    ),
  );
}

Widget iTextFieldv2(
  String name,
  bool isPassword,
  TextEditingController text,
  String currentCal,
) {
  return Container(
    constraints: BoxConstraints(maxWidth: 500),
    child: Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(name,
              style: const TextStyle(
                  fontSize: 15, color: Colors.grey, fontFamily: "Afacad")),
        ),
        Container(
            // margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 36, 36, 36),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: text,
              obscureText: isPassword,
              cursorColor: const Color.fromARGB(255, 255, 255, 255),
              style: const TextStyle(
                  color: Colors.white,
                  decorationThickness: 0,
                  height: 1.5,
                  fontFamily: "Afacad",
                  fontSize: 20),
              decoration: InputDecoration(
                hintText: currentCal,
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                border: InputBorder.none,
              ),
            )),
      ],
    ),
  );
}

Widget iButton(String name, VoidCallback onPressed) {
  return (ElevatedButton(
    style: ElevatedButton.styleFrom(
        side: const BorderSide(width: 2.0, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        shadowColor: const Color.fromARGB(255, 50, 50, 50),
        backgroundColor: Colors.black,
        minimumSize: const Size(130, 50)),
    onPressed: onPressed,
    child: Text(
      name,
      style: TextStyle(
          fontFamily: "Afacad",
          fontSize: 26,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    ),
  ));
}

Widget iSmallButton(String btnName, VoidCallback onPress) {
  return (ElevatedButton(
    onPressed: onPress,
    style: ElevatedButton.styleFrom(
        side: const BorderSide(width: 2, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        elevation: 4,
        backgroundColor: Colors.black,
        minimumSize: const Size(0, 35)),
    child: Text(
      btnName,
      style: TextStyle(
          fontFamily: "Afacad",
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16),
    ),
  ));
}

class StudentCard extends StatefulWidget {
  final String stdName;
  final double todayCalPrecent;
  final VoidCallback onPress;

  const StudentCard(
      {super.key,
      required this.stdName,
      required this.todayCalPrecent,
      required this.onPress});

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  void _expand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext content) {
    return AnimatedContainer(
      duration: Durations.short3,
      height: isExpanded ? 350 : 130,
      width: 400,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: const Color.fromARGB(66, 0, 0, 0),
              offset: Offset(0, 10),
              blurRadius: 10,
              spreadRadius: 1)
        ],
        color: Colors.black,
        border: Border.all(color: Colors.white, width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // push content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.stdName,
                        style: const TextStyle(
                            fontSize: 25,
                            fontFamily: "Afacad",
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: SvgPicture.asset('assets/icons/editicon.svg'),
                        color: Colors.white,
                        style: IconButton.styleFrom(iconSize: 0.1),
                        onPressed: () {
                          // _updateHeight(500.0);
                          _expand();
                        },
                      ),
                    ],
                  ),
                  Text(
                    "ID: 20340432",
                    style: TextStyle(
                        color: Colors.grey, fontSize: 12, fontFamily: "Afacad"),
                  ),
                  if (isExpanded)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Gender: ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontFamily: "Afacad"),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Age: ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontFamily: "Afacad"),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Height: ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontFamily: "Afacad"),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Weight: ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontFamily: "Afacad"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        iTextFieldv2("Daily Calorie inTake", false,
                            TextEditingController(), "2"),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: iButton("Submit", () {}))
                      ],
                    )
                ],
              ),
              if (!isExpanded)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Todays Goal",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                    iMiniProgress(widget.todayCalPrecent)
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}

Widget iMiniProgress(double progress) {
  return SizedBox(
    width: 50,
    height: 50,
    child: Stack(alignment: Alignment.center, children: [
      CircularProgressIndicator(
        strokeCap: StrokeCap.round,
        color: const Color.fromARGB(255, 34, 141, 255),
        strokeWidth: 6,
        value: progress / 100,
      ),
      Text(
        "${(progress).toInt()}%",
        style: TextStyle(
            fontFamily: "Afacad",
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold),
      )
    ]),
  );
}

Widget iLoadingAnimation() {
  return Scaffold(
    body: Center(
        child: LoadingAnimationWidget.stretchedDots(
            color: Colors.black87, size: 200)),
  );
}
