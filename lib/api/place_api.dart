import 'dart:convert';
import 'dart:io';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/place_api_exception.dart';
import 'package:fretto/models/place_suggestion.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:http/http.dart' as http;

class PlaceApi {
  final log = getLogger('PlaceApi');
  final EnvironmentService _environmentService = locator<EnvironmentService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<List<PlaceSuggestion>> fetchPlaceSuggestions(
      String input,
      String localeLanguageCode,
      String localeCountryCode,
      String countryCode,
      int numberOfResults) async {
    var queryParams = {
      "lang": localeLanguageCode + '_' + localeCountryCode,
      "country": countryCode,
      "input": input.trim(),
      "limit": numberOfResults.toString()
    };

    var localityAutocompleteUri = Uri.https(
        _environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/places',
        queryParams);

    try {
      final response = await http.get(
        localityAutocompleteUri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${_authenticationService.token!}",
          HttpHeaders.contentTypeHeader: "application/json"
        },
      );

      var responseData;

      if (response.statusCode != 200) {
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
          throw PlaceApiException(message: errorMessage);
        } else {
          throw PlaceApiException(
              message: 'Response status code: ${response.statusCode}');
        }
      }

      responseData = json.decode(response.body);

      final extractedData = responseData as Map<String, dynamic>;

      var content = extractedData["content"] as List;

      List<PlaceSuggestion> localitySuggestions = content
          .map<PlaceSuggestion>((json) => PlaceSuggestion.fromJson(json))
          .toList();

      return localitySuggestions;
    } catch (error) {
      throw error;
    }
  }

  Future<List<PlaceSuggestion>> fetchDepartmentSuggestions(
      String input,
      String localeLanguageCode,
      String localeCountryCode,
      String countryCode,
      int numberOfResults) async {
    var queryParams = {
      "lang": localeLanguageCode + '_' + localeCountryCode,
      "country": countryCode,
      "input": input.trim(),
      "limit": numberOfResults.toString()
    };

    var departmentAutocompleteUri = Uri.https(
        _environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/departments',
        queryParams);

    try {
      final response = await http.get(
        departmentAutocompleteUri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${_authenticationService.token!}",
          HttpHeaders.contentTypeHeader: "application/json"
        },
      );
      var responseData;
      if (response.statusCode != 200) {
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
          throw PlaceApiException(message: errorMessage);
        } else {
          throw PlaceApiException(
              message: 'Response status code: ${response.statusCode}');
        }
      }

      responseData = json.decode(response.body);

      final extractedData = responseData as Map<String, dynamic>;

      var content = extractedData["content"] as List;

      List<PlaceSuggestion> departmentSuggestions = content
          .map<PlaceSuggestion>((json) => PlaceSuggestion.fromJson(json))
          .toList();

      return departmentSuggestions;
    } catch (error) {
      throw error;
    }
  }
}
