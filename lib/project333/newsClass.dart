import 'package:equatable/equatable.dart';

class NewsClass extends Equatable {
  final String title, body, img, author;
  

  NewsClass({
    required this.title,
    required this.body,
    required this.img,
    required this.author,
  });
  
  @override
  List<Object?> get props => [
         title,
        body,
        img,
        author,

      ];
}
