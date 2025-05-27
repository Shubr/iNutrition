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
                  color:
                      const Color.fromARGB(255, 104, 104, 104).withOpacity(0.1),
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
        side: const BorderSide(width: 2.0, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        elevation: 4,
        backgroundColor: Colors.black,
        minimumSize: const Size(0, 35)),
    child: Text(
      btnName,
      style: TextStyle(
          fontFamily: "Afacad",
          color: Colors.white,
          fontWeight: FontWeight.bold),
    ),
  ));
}

Widget iStudentCard(
    String stName, double todayCaloriePrecent, VoidCallback onPress) {
  return Container(
    height: 120,
    width: 500,
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
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // push content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stName,
                style: const TextStyle(
                    fontSize: 25,
                    fontFamily: "Afacad",
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: SvgPicture.asset('assets/icons/editicon.svg'),
                color: Colors.white,
                onPressed: onPress,
              ),
            ],
          ),
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
              iMiniProgress(todayCaloriePrecent),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget iMiniProgress(double progress) {
  return SizedBox(
    width: 50,
    height: 50,
    child: Stack(alignment: Alignment.center, children: [
      CircularProgressIndicator(
        strokeCap: StrokeCap.round,
        color: const Color.fromARGB(255, 34, 141, 255),
        strokeWidth: 5,
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
