class Player {
  String name;
  String battingId;
  String bowlingId;
  String teamName;
  String role;
  String imageUrl;

  Player(
      {required this.name,
      required this.teamName,
      required this.role,
      required this.imageUrl,
      required this.battingId,
      required this.bowlingId});

  static Player fromJson(Map<String, dynamic> json) => Player(
        name: json['name'],
        imageUrl: json['imageUrl'],
        battingId: json['battingId'],
        bowlingId: json['bowlingId'],
        role: json['role'],
        teamName: json['team'],
      );
}
