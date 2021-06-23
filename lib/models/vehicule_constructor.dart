class VehiculeConstructor {
  final int id;
  final String name;
  VehiculeConstructor({required this.id, required this.name});

  factory VehiculeConstructor.fromJson(Map<String, dynamic> json) {
    return VehiculeConstructor(id: json["id"], name: json["name"]);
  }
}
