import 'dart:convert';
import 'dart:io';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/journey_request_api_exception.dart';
import 'package:fretto/exceptions/mobile_validation_exception.dart';
import 'package:fretto/models/client_journey_requests_result.dart';
import 'package:fretto/models/journey_request_search_result.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:http/http.dart' as http;

class JourneyRequestApi {
  final log = getLogger('JourneyRequestApi');
  final EnvironmentService _environmentService = locator<EnvironmentService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<JourneyRequestSearchResult> fetchJourneyRequestsPage(
      int departurePlaceRegionId,
      int arrivalPlaceRegionId,
      DateTime startDateTime,
      DateTime endDateTime,
      List<int> engineTypeIds,
      int page,
      int size,
      String sort) async {
    var queryParams = {
      "departure": departurePlaceRegionId,
      "arrival": arrivalPlaceRegionId,
      "fromDate": startDateTime.toIso8601String(),
      "toDate": endDateTime.toIso8601String(),
      "engine": engineTypeIds,
      "page": page,
      "size": size,
      "sort": sort
    };
    var journeyRequestsUri = Uri.https(
        _environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/journey-requests',
        queryParams);
    log.v('Start fetching journey requests page : $page of size $size');
    try {
      final response = await http.get(
        journeyRequestsUri,
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${_authenticationService.token!}',
          HttpHeaders.contentTypeHeader: "application/json"
        },
      );

      var responseData;

      if (response.statusCode != 200) {
        if (response.body.isNotEmpty) {
          responseData = json.decode(response.body);
          if (responseData['errors'] != null) {
            var errorsList = responseData['errors'];
            var strBuffer = StringBuffer();
            errorsList.forEach((item) {
              strBuffer.write(item);
              strBuffer.write(', ');
            });
            String errorMessage = strBuffer
                .toString()
                .substring(0, strBuffer.toString().length - 2);
            throw JourneyRequestApiException(
                message: errorMessage, statusCode: response.statusCode);
          } else {
            throw JourneyRequestApiException(
                message: 'Response status code: ${response.statusCode}',
                statusCode: response.statusCode);
          }
        } else {
          throw JourneyRequestApiException(
              message: 'Response status code: ${response.statusCode}',
              statusCode: response.statusCode);
        }
      }

      responseData = json.decode(response.body);

      final extractedData = responseData as Map<String, dynamic>;

      JourneyRequestSearchResult result =
          JourneyRequestSearchResult.fromJson(extractedData);
      log.v('End fetching journey requests page : $page of size $size');

      return result;
    } catch (error) {
      throw error;
    }
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
    Map<String, String> requestBody = {
      "departurePlaceId": departurePlaceId.toString(),
      "departurePlaceType": departurePlaceType,
      "arrivalPlaceId": arrivalPlaceId.toString(),
      "arrivalPlaceType": arrivalPlaceType,
      "dateTime": dateTime.toIso8601String(),
      "engineTypeId": engineTypeId.toString(),
      "workers": workers.toString(),
      "description": description
    };
    var journeyRequestsUri = Uri.https(_environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/journey-requests');

    try {
      final response = await http.post(
        journeyRequestsUri,
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${_authenticationService.token!}',
          HttpHeaders.contentTypeHeader: "application/json"
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode != 201) {
        if (response.body.isNotEmpty) {
          var responseData = json.decode(response.body);
          if (responseData['errorCode'] != null &&
              responseData['errors'] != null) {
            String errorsCode = responseData['errorCode'];
            var errorsList = json.decode(response.body)['errors'];
            var strBuffer = StringBuffer();
            errorsList.forEach((item) {
              strBuffer.write(item);
              strBuffer.write(', ');
            });
            String errorMessage = strBuffer
                .toString()
                .substring(0, strBuffer.toString().length - 2);
            if (errorsCode == 'MOBILE_VALIDATION') {
              throw MobileValidationException(errorMessage);
            } else {
              throw JourneyRequestApiException(
                  message: errorMessage, statusCode: response.statusCode);
            }
          }
        }
        throw JourneyRequestApiException(
            message: 'Received status code:' + response.statusCode.toString(),
            statusCode: response.statusCode);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> cancelJourneyRequest(int id) async {
    var journeyRequestsUri = Uri.https(_environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/journey-requests/$id/status');
    Map<String, String> requestBody = {"status": "canceled"};
    try {
      final response = await http.patch(journeyRequestsUri,
          headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ${_authenticationService.token!}',
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: jsonEncode(requestBody));

      if (response.statusCode != 204) {
        if (response.body.isNotEmpty) {
          var responseData = json.decode(response.body);
          if (responseData['errorCode'] != null &&
              responseData['errors'] != null) {
            var errorsList = json.decode(response.body)['errors'];
            var strBuffer = StringBuffer();
            errorsList.forEach((item) {
              strBuffer.write(item);
              strBuffer.write(', ');
            });
            String errorMessage = strBuffer
                .toString()
                .substring(0, strBuffer.toString().length - 2);
            throw JourneyRequestApiException(
                message: errorMessage, statusCode: response.statusCode);
          }
        }

        throw JourneyRequestApiException(
            message: 'Received status code:' + response.statusCode.toString(),
            statusCode: response.statusCode);
      }
    } catch (error) {
      throw error;
    }
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
    Map<String, String> requestBody = {
      "departurePlaceId": departurePlaceId.toString(),
      "departurePlaceType": departurePlaceType,
      "arrivalPlaceId": arrivalPlaceId.toString(),
      "arrivalPlaceType": arrivalPlaceType,
      "dateTime": dateTime.toIso8601String(),
      "engineTypeId": engineTypeId.toString(),
      "workers": workers.toString(),
      "description": description
    };
    var journeyRequestsUri = Uri.https(_environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/journey-requests/$journeyId');

    try {
      final response = await http.patch(
        journeyRequestsUri,
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${_authenticationService.token!}',
          HttpHeaders.contentTypeHeader: "application/json"
        },
        body: jsonEncode(requestBody),
      );
      var responseData;
      if (response.statusCode != 204) {
        if (response.body.isNotEmpty &&
            responseData['errorCode'] != null &&
            responseData['errors'] != null) {
          responseData = json.decode(response.body);

          var errorsList = json.decode(response.body)['errors'];
          var strBuffer = StringBuffer();
          errorsList.forEach((item) {
            strBuffer.write(item);
            strBuffer.write(', ');
          });
          String errorMessage = strBuffer
              .toString()
              .substring(0, strBuffer.toString().length - 2);

          throw JourneyRequestApiException(
              message: errorMessage, statusCode: response.statusCode);
        }
        throw JourneyRequestApiException(
            message: 'Received status code:' + response.statusCode.toString(),
            statusCode: response.statusCode);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<ClientJourneyRequestsResult> fetchClientJourneyRequestsResult(
      String period,
      int page,
      int size,
      String sort,
      String localeLanguageCode,
      String localeCountryCode) async {
    var queryParams = {
      'lang': localeLanguageCode + '_' + localeCountryCode,
      'period': period,
      'page': page.toString(),
      'size': size.toString(),
      'sort': sort
    };
    var clientJourneyRequestsUri = Uri.https(
        _environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/users/me/journey-requests',
        queryParams);

    try {
      final response = await http.get(
        clientJourneyRequestsUri,
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${_authenticationService.token!}',
          HttpHeaders.contentTypeHeader: "application/json"
        },
      );

      var responseData;

      if (response.statusCode != 200) {
        if (response.body.isNotEmpty) {
          responseData = json.decode(response.body);
          if (responseData['errors'] != null) {
            var errorsList = responseData['errors'];
            var strBuffer = StringBuffer();
            errorsList.forEach((item) {
              strBuffer.write(item);
              strBuffer.write(', ');
            });
            String errorMessage = strBuffer
                .toString()
                .substring(0, strBuffer.toString().length - 2);
            throw JourneyRequestApiException(
                message: errorMessage, statusCode: response.statusCode);
          } else {
            throw JourneyRequestApiException(
                message: 'Response status code: ${response.statusCode}',
                statusCode: response.statusCode);
          }
        } else {
          throw JourneyRequestApiException(
              message: 'Response status code: ${response.statusCode}',
              statusCode: response.statusCode);
        }
      }

      ClientJourneyRequestsResult result = ClientJourneyRequestsResult.fromJson(
          json.decode(response.body) as Map<String, dynamic>);

      return result;
    } catch (error) {
      throw error;
    }
  }
}
