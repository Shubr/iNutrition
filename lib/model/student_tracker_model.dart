class StudentTrackerModel {
  final String studentId;
  final String firstName;
  final String lastName;
  final String age;
  final String gender;
  final String dailyCal;
  final String currentInTake;

  StudentTrackerModel(
      {required this.studentId,
      required this.firstName,
      required this.lastName,
      required this.age,
      required this.gender,
      required this.dailyCal,
      required this.currentInTake});

  Map<String, dynamic> toMap() => {
        "studentId": studentId,
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "gender": gender,
        "dailyCal": dailyCal,
        "currentInTake": currentInTake
      };

  factory StudentTrackerModel.fromMap(Map<String, dynamic> map) {
    return StudentTrackerModel(
        studentId: map['studentId'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        age: map['age'],
        gender: map['gender'],
        dailyCal: map['dailyCal'],
        currentInTake: map['currentInTake']);
  }
}
