import 'dart:convert';
import 'dart:io';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/country_api_exception.dart';
import 'package:fretto/models/engine_type.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:http/http.dart' as http;

class EngineTypeApi {
  final log = getLogger('EngineTypeApi');
  final EnvironmentService _environmentService = locator<EnvironmentService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  Future<List<EngineType>> fetchEngineTypes(
      String localeLanguageCode, String localeCountryCode) async {
    String lang = localeLanguageCode + "_" + localeCountryCode;
    log.v('Start fetching engine types with locale : $lang');

    Map<String, String> queryParams = {"lang": lang};

    var engineTypesUri = Uri.https(_environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/engine-types', queryParams);

    try {
      final response = await http.get(
        engineTypesUri,
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
            throw CountryApiException(message: errorMessage);
          } else {
            throw CountryApiException(
                message: 'Response status code: ${response.statusCode}');
          }
        } else {
          throw CountryApiException(
              message: 'Response status code: ${response.statusCode}');
        }
      }

      responseData = json.decode(response.body);

      final extractedData = responseData as Map<String, dynamic>;

      List content = extractedData["content"] as List;

      return content
          .map<EngineType>((json) => EngineType.fromJson(json))
          .toList();
    } catch (error) {
      throw error;
    }
  }
}
