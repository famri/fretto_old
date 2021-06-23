import 'package:decimal/decimal.dart';

class GeoPlaceDto {
  final int id;

  final String name;

  final Decimal latitude;

  final Decimal longitude;

  final DepartmentDto department;

  GeoPlaceDto(
      {required this.id, required this.name, required this.latitude,required  this.longitude, required this.department});

  factory GeoPlaceDto.fromJson(Map<String, dynamic> json) {
    return GeoPlaceDto(
        id: json["id"],
        name: json["name"],
        latitude: Decimal.parse(json["latitude"].toString()),
        longitude: Decimal.parse(json["longitude"].toString()),
        department: DepartmentDto.fromJson(json["department"]));
  }
}

class DepartmentDto {
  final int id;
  final String name;

  DepartmentDto({required this.id, required this.name});

  factory DepartmentDto.fromJson(Map<String, dynamic> json) {
    return DepartmentDto(id: json["id"], name: json["name"]);
  }
}
