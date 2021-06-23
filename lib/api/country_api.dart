import 'dart:convert';
import 'dart:io';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/country_api_exception.dart';
import 'package:fretto/models/country.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:http/http.dart' as http;

class CountryApi {
  final log = getLogger('CountryApi');
  final EnvironmentService environmentService = locator<EnvironmentService>();

  Future<List<Country>> fetchCountries(
      String localeLanguageCode, String localeCountryCode) async {
    String lang = localeLanguageCode + "_" + localeCountryCode;
    log.v('Start fetching countries with locale : $lang');

    Map<String, String> queryParams = {"lang": lang};

    var countriesUri = Uri.https(environmentService.getValue(AppDomain),
        environmentService.getValue(AppName) + '/countries', queryParams);

    try {
      final response = await http.get(
        countriesUri,
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
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
      log.v('End fetching countries with locale : $lang ==> $content');

      return content.map<Country>((json) => Country.fromJson(json)).toList();
    } catch (error) {
      throw error;
    }
  }
}
