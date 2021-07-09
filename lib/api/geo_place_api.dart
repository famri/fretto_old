import 'dart:convert';
import 'dart:io';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/geo_place_api_exception.dart';
import 'package:fretto/models/geo_place_dto.dart';
import 'package:fretto/models/place_location.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:http/http.dart' as http;

class GeoPlaceApi {
  final log = getLogger('GeoPlaceApi');
  final EnvironmentService _environmentService = locator<EnvironmentService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<List<GeoPlaceDto>?> fetchFavoriteGeoPlaces(
      String localeLanguageCode, String localeCountryCode) async {
    String lang = localeLanguageCode + "_" + localeCountryCode;
    log.v('Start fetching favorite geo-places with locale : $lang');

    Map<String, String> queryParams = {"lang": lang};

    var geoPlacesUri = Uri.https(_environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/geo-places', queryParams);

    try {
      final response = await http.get(
        geoPlacesUri,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:
              "Bearer ${_authenticationService.token!}"
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
            throw GeoPlaceApiException(message: errorMessage);
          } else {
            throw GeoPlaceApiException(
                message: 'Response status code: ${response.statusCode}');
          }
        } else {
          throw GeoPlaceApiException(
              message: 'Response status code: ${response.statusCode}');
        }
      }

      responseData = json.decode(response.body);

      final extractedData = responseData as Map<String, dynamic>;

      List content = extractedData["content"] as List;
      log.v(
          'End fetching favorite geo-places with locale : $lang ==> $content');

      return content
          .map<GeoPlaceDto>((json) => GeoPlaceDto.fromJson(json))
          .toList();
    } catch (error) {
      throw error;
    }
  }

  Future<GeoPlaceDto> saveFavoriteGeoPlace(
      String placeName,
      PlaceLocation placeLocation,
      String localeLanguageCode,
      String localeCountryCode) async {
    String lang = localeLanguageCode + "_" + localeCountryCode;
    var queryParams = {"lang": lang};
    var geoPlacesUri = Uri.https(_environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/geo-places', queryParams);
    Map<String, String> requestBody = {
      "latitude": placeLocation.latitude.toString(),
      "longitude": placeLocation.longitude.toString(),
      "name": placeName
    };

    try {
      final response = await http.post(
        geoPlacesUri,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:
              "Bearer ${_authenticationService.token!}"
        },
        body: jsonEncode(requestBody),
      );

      var responseData;
      if (response.statusCode != 201) {
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
            throw GeoPlaceApiException(message: errorMessage);
          }
        }
        throw GeoPlaceApiException(
            message: 'Received status code:' + response.statusCode.toString());
      }

      responseData = json.decode(response.body);
      GeoPlaceDto createdGeoPlace =
          GeoPlaceDto.fromJson(responseData as Map<String, dynamic>);

      return createdGeoPlace;
    } catch (error) {
      throw error;
    }
  }
}
