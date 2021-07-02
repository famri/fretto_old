import 'package:fretto/models/journey_request_search_dto.dart';

class JourneyRequestSearchResult {
  final int totalPages;
  final int totalElements;
  final int pageNumber;
  final int pageSize;
  final bool hasNext;

  final List<JourneyRequestSearchDto> content;

  JourneyRequestSearchResult(
      {required this.totalPages,
      required this.totalElements,
      required this.pageNumber,
      required this.pageSize,
      required this.hasNext,
      required this.content});

  factory JourneyRequestSearchResult.fromJson(Map<String, dynamic> json) {
    return JourneyRequestSearchResult(
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        hasNext: json["hasNext"],
        content: (json["content"] as List)
            .map<JourneyRequestSearchDto>(
                (json) => JourneyRequestSearchDto.fromJson(json))
            .toList());
  }
}
