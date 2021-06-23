import 'place_dto.dart';

class ClientJourneyRequestDto {
  final int id;
  final PlaceDto departurePlace;
  final PlaceDto arrivalPlace;
  final EngineTypeDto engineType;
  final int distance;
  final DateTime dateTime;
  final DateTime creationDateTime;
  final int workers;
  final String description;
  final int proposalsCount;

  ClientJourneyRequestDto(
      {required this.id,
      required this.departurePlace,
      required this.arrivalPlace,
      required this.engineType,
      required this.distance,
      required this.dateTime,
      required this.creationDateTime,
      required this.workers,
      required this.description,
      required this.proposalsCount});

  factory ClientJourneyRequestDto.fromJson(Map<String, dynamic> json) {
    return ClientJourneyRequestDto(
        id: json["id"],
        departurePlace: PlaceDto.fromJson(json["departurePlace"]),
        arrivalPlace: PlaceDto.fromJson(json["arrivalPlace"]),
        engineType: EngineTypeDto.fromJson(json["engineType"]),
        distance: (json["distance"] / 1000).toInt(),
        dateTime: DateTime.parse(json["dateTime"]),
        creationDateTime: DateTime.parse(json["creationDateTime"]),
        workers: json["workers"],
        description: json["description"],
        proposalsCount: json["proposalsCount"]);
  }
}

class EngineTypeDto {
  final int id;
  final String code;
  final String name;

  EngineTypeDto({required  this.id, required this.code, required this.name});
  factory EngineTypeDto.fromJson(Map<String, dynamic> json) {
    return EngineTypeDto(
      id: json["id"],
      code: json["code"],
      name: json["name"],
    );
  }
}
