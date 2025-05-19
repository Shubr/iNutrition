class StudentModel {
  String? studentId;
  String? firstName;
  String? lastName;
  int? age;
  String? gender;
  double? height;
  double? weight;
  String? ethnicity;
  String? medicalCondition;
  double? goalWeight;
  double? dailyCal;
  double? assignedNurse;
  double? eMail;
}

class NurseModel {
  String? studentId;
  String? firstName;
  String? lastName;
  String? collegeName;
  String? courseName;
  String? eMail;
  NurseModel(studentid, firstname, lastname, collegename, coursename, email) {
    studentId = studentid;
    firstName = firstname;
    lastName = lastname;
    collegeName = collegename;
    courseName = collegename;
    eMail = email;
  }

  Map<String, dynamic> conver() {
    var info = {
      "studentId": studentId,
      "fistName": firstName,
      "lastName": lastName,
      "college": collegeName,
      "course": courseName,
      "eMail": eMail
    };

    return info;
  }
}
