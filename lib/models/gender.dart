class Gender {
  final int id;
  final String name;

  Gender({required this.id, required this.name});

  factory Gender.fromJson(Map<String, dynamic> jsonMap) {
    return Gender(id: jsonMap["id"], name: jsonMap["name"]);
  }
}
