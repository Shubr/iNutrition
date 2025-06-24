import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inutrition/model/student_tracker_model.dart';
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
  final StudentTrackerModel studentDetails;

  const StudentCard(
      {super.key,
      required this.stdName,
      required this.todayCalPrecent,
      required this.onPress,
      required this.studentDetails});

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
                    "ID: ${widget.studentDetails.studentId}",
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
                                "Gender: ${widget.studentDetails.gender}",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontFamily: "Afacad"),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Age: ${widget.studentDetails.age}",
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
                        iTextFieldv2(
                            "Daily Calorie inTake",
                            false,
                            TextEditingController(),
                            widget.studentDetails.dailyCal),
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

class iRadio extends StatefulWidget {
  final String category;
  final String title1;
  final String title2;
  final String selected;
  final void Function(String)? onChange;

  const iRadio(
      {super.key,
      required this.category,
      required this.title1,
      required this.title2,
      required this.selected,
      this.onChange});

  @override
  State<iRadio> createState() => _iRadioState();
}

class _iRadioState extends State<iRadio> {
  @override
  void initState() {
    super.initState();
  }

  var selected = "";

  _updateRadio(String value) {
    setState(() {
      selected = value;
    });
    widget.onChange?.call(value);
  }

  @override
  Widget build(BuildContext content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.category,
          style:
              TextStyle(fontSize: 15, color: Colors.grey, fontFamily: "Afacad"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Transform.scale(
                  scale: 2,
                  child: Radio(
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.blue;
                      }
                      return Color.fromRGBO(
                          178, 178, 178, 100); // default color
                    }),
                    value: widget.title1,
                    groupValue: widget.selected,
                    onChanged: (onChanged) {
                      _updateRadio("Male");
                    },
                  ),
                ),
                Text(
                  widget.title1,
                  style: TextStyle(
                      fontSize: 15, color: Colors.grey, fontFamily: "Afacad"),
                ),
              ],
            ),
            Row(
              children: [
                Transform.scale(
                  scale: 2,
                  child: Radio(
                      value: widget.title2,
                      groupValue: widget.selected,
                      fillColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.blue;
                        }
                        return Color.fromRGBO(
                            178, 178, 178, 100); // default color
                      }),
                      onChanged: (onChanged) {
                        _updateRadio("Female");
                      }),
                ),
                Text(
                  widget.title2,
                  style: TextStyle(
                      fontSize: 15, color: Colors.grey, fontFamily: "Afacad"),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

Widget iNavigator() {
  return SizedBox(
    width: 280,
    height: 80,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/homeicon.svg",
              width: 30,
              height: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/donuticon.svg",
              width: 30,
              height: 30,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -30), // push up
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black, // background to contrast the white icon
                border: Border.all(color: Colors.white, width: 5),
              ),
              child: SvgPicture.asset(
                'assets/icons/barcodeicon.svg',
                width: 40,
                height: 40,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/statsicon.svg",
              width: 30,
              height: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/settingicon.svg",
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
    ),
  );
}
