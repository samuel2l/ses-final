class Grades {
  final String courseId;
  final String name;
  final String grade;
  final int credit;
  Grades({
    required this.courseId,
    required this.name,
    required this.grade,
    required this.credit,
  });

  factory Grades.fromJson(Map<String, dynamic> json) {
    return Grades(
      courseId: json['course_id'],
      name: json['course_name'],
      grade: json['grade'],
      credit: json['credit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_id': courseId,
      'course_name': name,
      'grade': grade,
      'credit': credit,
    };
  }
}
