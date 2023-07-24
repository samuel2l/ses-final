class User {
  int studentId;
  String firstName;
  String lastName;
  String studentMail;
  String department;
  int stLevel;
  String gender;

  User({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.studentMail,
    required this.department,
    required this.stLevel,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      studentId: json['student_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      studentMail: json['student_mail'],
      department: json['department'],
      stLevel: json['st_level'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'first_name': firstName,
      'last_name': lastName,
      'student_mail': studentMail,
      'department': department,
      'st_level': stLevel,
      'gender': gender,
    };
  }
}
