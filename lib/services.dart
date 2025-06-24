import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inutrition/model/student_tracker_model.dart';

Future<List<StudentTrackerModel>> getCurrentUserExecStudentAsList() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = auth.currentUser;

  if (user == null) return [];

  final email = user.email!;
  final snapshot = await firestore.collection("execStudent").get();

  List<StudentTrackerModel> matchedStudents = [];

  for (var doc in snapshot.docs) {
    final data = doc.data();
    if (data['assignedNurse'] == email) {
      matchedStudents.add(StudentTrackerModel(
        studentId: data['studentId'] ?? '',
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        age: data['age'] ?? '',
        gender: data['gender'] ?? '',
        dailyCal: data['dailyCal'] ?? '',
        currentInTake: "0", // default or fetch if you have it elsewhere
      ));
    }
  }

  return matchedStudents;
}
