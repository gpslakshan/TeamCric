class Team {
  String name;
  String imageUrl;

  Team({
    required this.name,
    required this.imageUrl,
  });

  static Team fromJson(Map<String, dynamic> json) => Team(
        name: json['name'],
        imageUrl: json['imageUrl'],
      );
}
