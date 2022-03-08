import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  String title;
  String imageUrl;
  DateTime date;

  News({
    required this.title,
    required this.imageUrl,
    required this.date,
  });

  static News fromJson(Map<String, dynamic> json) => News(
        title: json['title'],
        imageUrl: json['imageUrl'],
        date: (json['date'] as Timestamp).toDate(),
      );
}
