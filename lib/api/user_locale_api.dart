import 'dart:convert';
import 'dart:io';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/user_locale_api_exception.dart';
import 'package:fretto/models/user_locale.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:http/http.dart' as http;

class UserLocaleApi {
  final log = getLogger('UserLocaleApi');
  final EnvironmentService environmentService = locator<EnvironmentService>();

  Future<List<UserLocale>> fetchUserLocales() async {
    log.v('Start fetching user locales');

    var userLocalesUri = Uri.https(environmentService.getValue(AppDomain),
        environmentService.getValue(AppName) + '/locales');

    try {
      final response = await http.get(
        userLocalesUri,
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
            throw UserLocaleApiException(message: errorMessage);
          } else {
            throw UserLocaleApiException(
                message: 'Response status code: ${response.statusCode}');
          }
        } else {
          throw UserLocaleApiException(
              message: 'Response status code: ${response.statusCode}');
        }
      }

      responseData = json.decode(response.body);

      final extractedData = responseData as Map<String, dynamic>;

      List content = extractedData["content"];

      log.v('End fetching user locales ==> $content');

      return List<UserLocale>.from(content.map<UserLocale>(
          (userLocaleJson) => UserLocale.fromJson(userLocaleJson)));
    } catch (error) {
      throw error;
    }
  }
}
