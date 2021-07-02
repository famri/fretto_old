import 'package:fretto/api/journey_request_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/models/journey_request_create_dto.dart';
import 'package:fretto/models/journey_request_search_result.dart';
import 'package:logger/logger.dart';

class JourneyRequestService {
  Logger log = getLogger('JourneyRequestService');
  JourneyRequestApi _journeyRequestApi = locator<JourneyRequestApi>();

  Future<JourneyRequestSearchResult> searchJourneyRequests(
      int departurePlaceRegionId,
      int arrivalPlaceRegionId,
      DateTime startDateTime,
      DateTime endDateTime,
      List<int> engineTypeIds,
      int page,
      int size,
      String sort) async {
    return _journeyRequestApi.fetchJourneyRequestsPage(
        departurePlaceRegionId,
        arrivalPlaceRegionId,
        startDateTime,
        endDateTime,
        engineTypeIds,
        page,
        size,
        sort);
  }

  Future<void> createJourneyRequest(
      int departurePlaceId,
      String departurePlaceType,
      int arrivalPlaceId,
      String arrivalPlaceType,
      DateTime dateTime,
      int engineTypeId,
      int workers,
      String description) async {
    await _journeyRequestApi.createJourneyRequest(
        departurePlaceId,
        departurePlaceType,
        arrivalPlaceId,
        arrivalPlaceType,
        dateTime,
        engineTypeId,
        workers,
        description);
  }

  Future<void> updateJourneyRequest(
      int journeyId,
      int departurePlaceId,
      String departurePlaceType,
      int arrivalPlaceId,
      String arrivalPlaceType,
      DateTime dateTime,
      int engineTypeId,
      int workers,
      String description) async {
    return _journeyRequestApi.updateJourneyRequest(
        journeyId,
        departurePlaceId,
        departurePlaceType,
        arrivalPlaceId,
        arrivalPlaceType,
        dateTime,
        engineTypeId,
        workers,
        description);
  }
}
