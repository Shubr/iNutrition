import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center, // Add this line
            children: [
              const Text(
                "eMail",
                style: TextStyle(
                    fontFamily: "Afacad",
                    fontSize: 18,
                    color: Color.fromARGB(255, 76, 76, 76)),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color.fromARGB(255, 223, 223, 223),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 104, 104, 104)
                          .withOpacity(0.1), // Shadow color
                      blurRadius: 10, // Blur strength
                      spreadRadius: 0, // Shadow spread
                      offset: const Offset(0, 10), // Position of the shadow
                    ),
                  ],
                ),
                child: const TextField(
                  style: TextStyle(height: 2),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              Text(
                "PasWord",
                style: TextStyle(
                    fontFamily: "Afacad",
                    fontSize: 18,
                    color: Color.fromARGB(255, 76, 76, 76)),
              ),
              TextField(
                style: TextStyle(height: 2),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(67, 104, 104, 104)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(67, 104, 104, 104)),
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
