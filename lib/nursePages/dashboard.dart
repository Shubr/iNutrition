import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inutrition/auth/auth.dart';
import 'package:inutrition/widgets/iWidget.dart';
import 'package:inutrition/services.dart';

class NurseingDashboard extends StatefulWidget {
  const NurseingDashboard({super.key});

  @override
  State<NurseingDashboard> createState() => _NurseingDashboardState();
}

class _NurseingDashboardState extends State<NurseingDashboard> {
  String? firstName;
  String? lastName;
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    var fireStore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    var email;
    if (user != null) {
      email = user.email;
    } else {
      return;
    }
    print("-------------");
    print(user.email);

    // Check nursingStudent
    final nurseDocRef = fireStore.collection("nursingStudent").doc(email);
    final nurseDoc = await nurseDocRef.get();

    if (nurseDoc.exists) {
      final data = nurseDoc.data();
      setState(() {
        firstName = data?['firstName'];
        lastName = data?['lastName'];
      });
      return;
    }

    // Check execStudent
    final execDocRef = fireStore.collection("execStudent").doc(email);
    final execDoc = await execDocRef.get();

    if (execDoc.exists) {
      final data = execDoc.data();
      setState(() {
        firstName = data?['firstName'];
        lastName = data?['lastName'];
      });
      print("Exec Student: $firstName $lastName");
      return;
    }

    print("User not found in either collection");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  try {
                    signOut();
                    Navigator.pushReplacementNamed(context, '/login');
                  } catch (e) {
                    print(e);
                  }
                },
                icon: SvgPicture.asset(
                  "assets/icons/sign_outIcon.svg",
                ))
          ],
          centerTitle: false,
          title: Text(firstName != null && lastName != null
              ? "$firstName $lastName"
              : "Loading..."),
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 20,
              fontFamily: "Alex"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        iSmallButton("ADD", () {
                          Navigator.pushReplacementNamed(
                              context, '/registerExecStudent');
                        })
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 20,
                      children: [
                        // iStudentCard("Shubham Rangra", 40, () {}),
                        // iStudentCard("Antonio Munro", 90, () {}),
                        // iStudentCard("Jessey Tau", 80, () {}),
                        StudentCard(
                            stdName: "Shubham Rangra",
                            todayCalPrecent: 65,
                            onPress: () {}),
                        StudentCard(
                            stdName: "Antonio Munro",
                            todayCalPrecent: 80,
                            onPress: () {}),
                        StudentCard(
                            stdName: "Jesse Tau",
                            todayCalPrecent: 50,
                            onPress: () {})
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
