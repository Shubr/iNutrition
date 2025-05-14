import 'package:flutter/material.dart';

Widget iTextField(String name, bool isPassword) {
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
              obscureText: isPassword,
              cursorColor: Colors.black,
              style: const TextStyle(
                  height: 1.5, fontFamily: "Afacad", fontSize: 20),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        shadowColor: const Color.fromARGB(255, 50, 50, 50),
        backgroundColor: Colors.black,
        minimumSize: const Size(130, 50)),
    onPressed: onPressed,
    child: Text(
      name,
      style: const TextStyle(
          fontFamily: "Afacad", fontSize: 26, color: Colors.white),
    ),
  ));
}
