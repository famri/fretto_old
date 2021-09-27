import 'dart:convert';
import 'dart:io';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/device_token_api_exception.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:http/http.dart' as http;

class DeviceTokenApi {
  final log = getLogger('DeviceTokenApi');
  final EnvironmentService _environmentService = locator<EnvironmentService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<void> saveDeviceToken(String deviceToken) async {
    log.v('Start saving device toekn');

    var deviceTokenUri = Uri.https(_environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/accounts/me/device-token');

    Map<String, String> requestBody = {"token": deviceToken};
    try {
      final response = await http.patch(deviceTokenUri,
          headers: {
            HttpHeaders.authorizationHeader:
                "Bearer ${_authenticationService.token!}",
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: jsonEncode(requestBody));

      if (response.statusCode != 204) {
        if (response.body.isNotEmpty) {
          var responseData = json.decode(response.body);
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
            throw DeviceTokenApiException(message: errorMessage);
          } else {
            throw DeviceTokenApiException(
                message: 'Response status code: ${response.statusCode}');
          }
        } else {
          throw DeviceTokenApiException(
              message: 'Response status code: ${response.statusCode}');
        }
      }

      log.v('End saving device token');
    } catch (error) {
      throw error;
    }
  }
}
