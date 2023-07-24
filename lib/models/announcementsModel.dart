class Announcement {
  final String? title;
  final String? content;
  final String? DateCreated;
  final String? by;

  Announcement({
    required this.title,
    required this.content,
    required this.DateCreated,
    required this.by,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      title: json['title'],
      content: json['body'],
      DateCreated: json['date_created'],
      by: json['by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': content,
      'date_created': DateCreated,
      'by': by
    };
  }
}
