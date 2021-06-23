import 'package:decimal/decimal.dart';

class PlaceDto {
  final int id;

  final String type;

  final String name;

  final Decimal latitude;

  final Decimal longitude;

  final int departmentId;

  PlaceDto(
      {required this.id,
      required this.type,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.departmentId});

  factory PlaceDto.fromJson(Map<String, dynamic> json) {
    return PlaceDto(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        latitude: Decimal.parse(json["latitude"].toString()),
        longitude: Decimal.parse(json["longitude"].toString()),
        departmentId: json["departmentId"]);
  }
}
