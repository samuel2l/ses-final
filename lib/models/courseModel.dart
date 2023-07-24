class Course {
  final String code;
  final String name;
  final int credit;

  Course({
    required this.code,
    required this.name,
    required this.credit,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      code: json['code'],
      name: json['name'],
      credit: json['credit']
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'credit': credit,
    };
  }

}
