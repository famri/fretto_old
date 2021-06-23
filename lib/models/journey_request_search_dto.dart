import 'client.dart';
import 'engine_type.dart';
import 'place_dto.dart';

class JourneyRequestSearchDto {
  final int id;
  final PlaceDto departurePlace;
  final PlaceDto arrivalPlace;
  final EngineType engineType;
  final double distance;
  final DateTime dateTime;
  final DateTime endDateTime;
  final int workers;
  final String description;
  final Client client;
  final double minPrice;

  JourneyRequestSearchDto(
      {required this.id,
      required this.departurePlace,
      required this.arrivalPlace,
      required this.engineType,
      required this.distance,
      required this.dateTime,
      required this.endDateTime,
      required this.workers,
      required this.description,
      required this.client,
      required this.minPrice});

  factory JourneyRequestSearchDto.fromJson(Map<String, dynamic> json) {
    return JourneyRequestSearchDto(
        id: json["id"],
        departurePlace: PlaceDto.fromJson(json["departurePlace"]),
        arrivalPlace: PlaceDto.fromJson(json["arrivalPlace"]),
        engineType: json["engineType"],
        distance: json["distance"],
        dateTime: json["dateTime"],
        endDateTime: json["endDateTime"],
        workers: json["workers"],
        description: json["description"],
        client: Client.fromJson(json["client"]),
        minPrice: json["minPrice"]);
  }
}
