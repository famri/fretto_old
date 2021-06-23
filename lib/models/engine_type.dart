class EngineType {
  final int id;
  final String name;
  final String code;
  final String description;

  EngineType({required this.id, required this.name, required this.code,required  this.description});

  factory EngineType.fromJson(Map<String, dynamic> json) {
    return EngineType(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        description: json["description"]);
  }
}
