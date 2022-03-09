class Player {
  String name;
  String teamName;
  String role;
  String imageUrl;

  Player(
      {required this.name,
      required this.teamName,
      required this.role,
      required this.imageUrl});

  static Player fromJson(Map<String, dynamic> json) => Player(
        name: json['name'],
        imageUrl: json['imageUrl'],
        role: json['role'],
        teamName: json['team'],
      );
}
