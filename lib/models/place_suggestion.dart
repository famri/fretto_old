class PlaceSuggestion {
  int id;
  String type;
  String name;
  String delegation;
  String department;
  String country;

  PlaceSuggestion(
      {required this.id,
      required this.name,
      required this.type,
      required this.delegation,
      required this.department,
      required this.country});

  factory PlaceSuggestion.fromJson(Map<String, dynamic> json) {
    return PlaceSuggestion(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        delegation: json["delegation"],
        department: json["department"],
        country: json["country"]);
  }
}
