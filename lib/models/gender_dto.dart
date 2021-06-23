class GenderDto {
  final int id;
  final String name;

  GenderDto({required this.id, required this.name});

  factory GenderDto.fromJson(Map<String, dynamic> jsonMap) {
    return GenderDto(id: jsonMap["id"], name: jsonMap["name"]);
  }
}
