import 'client_journey_request_dto.dart';

class ClientJourneyRequestsResult {
  final int totalElements;
  final int totalPages;
  final int pageNumber;
  final int pageSize;
  final bool hasNext;

  final List<ClientJourneyRequestDto> journeyRequests;

  ClientJourneyRequestsResult(
      {required this.totalElements,
      required this.totalPages,
      required this.pageNumber,
      required this.pageSize,
      required this.hasNext,
      required this.journeyRequests});

  factory ClientJourneyRequestsResult.fromJson(Map<String, dynamic> json) {
    return ClientJourneyRequestsResult(
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        hasNext: json["hasNext"],
        journeyRequests: ((json["content"]) as List)
            .map<ClientJourneyRequestDto>(
                (element) => ClientJourneyRequestDto.fromJson(element))
            .toList());
  }
}
