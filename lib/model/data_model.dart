class ExecStudentModel {
  String? studentId;
  String? firstName;
  String? lastName;
  String? age;
  String? gender;
  String? height;
  String? weight;
  String? ethnicity;
  String? medicalCondition;
  String? goalWeight;
  String? dailyCal;
  String? assignedNurse;
  String? eMail;

  ExecStudentModel(
      studentid,
      firstname,
      lastname,
      age_,
      gender_,
      height_,
      weight_,
      ethnicity_,
      medicalcondition,
      goalweight,
      dailycal,
      assignednurse,
      email_) {
    studentId = studentid;
    firstName = firstname;
    lastName = lastName;
    age = age_;
    gender = gender_;
    height = height_;
    weight = weight_;
    ethnicity = ethnicity_;
    medicalCondition = medicalcondition;
    goalWeight = goalweight;
    dailyCal = dailycal;
    assignedNurse = assignednurse;
    eMail = email_;
  }

  Map<String, dynamic> conver() {
    var info = {
      "studentId": studentId,
      "firstName": firstName,
      "lastName": lastName,
      "age": age,
      "gender": gender,
      "height": height,
      "weight": weight,
      "ethnicity": ethnicity,
      "medicalCondition": medicalCondition,
      "goalWeight": goalWeight,
      "dailyCal": dailyCal,
      "assignedNurse": assignedNurse,
      "eMail": eMail
    };

    return info;
  }
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
    courseName = coursename;
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
