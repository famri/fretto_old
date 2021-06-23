class VehiculeModel {
  final int id;
  final String name;
  final double length;
  final double width;
  final double height;

  VehiculeModel(
      {required this.id,
      required this.name,
      required this.length,
      required this.width,
      required this.height});
  factory VehiculeModel.fromJson(Map<String, dynamic> json) {
    return VehiculeModel(
        id: json["id"],
        name: json["name"],
        length: json["length"],
        width: json["width"],
        height: json["height"]);
  }
}
