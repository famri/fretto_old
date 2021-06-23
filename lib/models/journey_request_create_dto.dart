import 'engine_type.dart';
import 'place_dto.dart';

class JourneyRequestCreateDto {
  final int id;
  final PlaceDto departurePlace;
  final PlaceDto arrivalPlace;
  final double distance;
  final DateTime dateTime;

  final EngineType engineType;
  final int workers;
  final String description;
  final String status;
  final DateTime creationDateTime;

  JourneyRequestCreateDto(
      {required this.id,
      required this.departurePlace,
      required this.arrivalPlace,
      required this.distance,
      required this.dateTime,
      required this.engineType,
      required this.workers,
      required this.description,
      required this.status,
      required this.creationDateTime});

  factory JourneyRequestCreateDto.fromJson(Map<String, dynamic> json) {
    return JourneyRequestCreateDto(
      id: json["id"],
      departurePlace: PlaceDto.fromJson(json["departurePlace"]),
      arrivalPlace: PlaceDto.fromJson(json["arrivalPlace"]),
      distance: json["distance"],
      dateTime: DateTime.parse(json["dateTime"]),
      engineType: EngineType.fromJson(json["engineType"]),
      workers: json["workers"],
      description: json["description"],
      status: json["status"],
      creationDateTime: DateTime.parse(json["creationDateTime"]),
    );
  }
}
