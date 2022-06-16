import 'package:cloud_firestore/cloud_firestore.dart';

class Match {
  String title;
  String team1;
  String team2;
  String team1IconUrl;
  String team2IconUrl;
  String team1Score;
  String team2Score;
  String team1Overs;
  String team2Overs;
  String resultDescription;
  DateTime date;

  Match(
      {required this.title,
      required this.team1,
      required this.team2,
      required this.team1Score,
      required this.team1IconUrl,
      required this.team2IconUrl,
      required this.team2Score,
      required this.resultDescription,
      required this.date,
      required this.team1Overs,
      required this.team2Overs});

  static Match fromJson(Map<String, dynamic> json) => Match(
        title: json['title'],
        team1: json['team1'],
        team2: json['team2'],
        team1Score: json['team1Score'],
        team1IconUrl: json['team1IconUrl'],
        team2IconUrl: json['team2IconUrl'],
        team2Score: json['team2Score'],
        resultDescription: json['resultDescription'],
        date: (json['date'] as Timestamp).toDate(),
        team1Overs: json['team1Overs'],
        team2Overs: json['team2Overs'],
      );
}
