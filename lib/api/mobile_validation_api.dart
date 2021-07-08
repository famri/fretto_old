import 'dart:convert';
import 'dart:io';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/mobile_validation_api_exception.dart';
import 'package:fretto/models/code_validation_result.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:http/http.dart' as http;

class MobileValidationApi {
  final log = getLogger('MobileValidationApi');
  final EnvironmentService _environmentService = locator<EnvironmentService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<void> sendMobileValidationCode(
      String iccValue, String mobileNumber, String locale) async {
    var queryParams = {
      "lang": locale,
    };

    var sendMobileValidationCodeUri = Uri.https(
        _environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/validation-codes/sms/send',
        queryParams);

    try {
      final response = await http.post(sendMobileValidationCodeUri,
          headers: {
            HttpHeaders.authorizationHeader:
                "Bearer ${_authenticationService.token!}",
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: json.encode({'mobileNumber': mobileNumber, 'icc': iccValue}));

      var responseData;

      if (response.statusCode != 202) {
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
            throw MobileValidationApiException(message: errorMessage);
          } else {
            throw MobileValidationApiException(
                message: 'Response status code: ${response.statusCode}');
          }
        } else {
          throw MobileValidationApiException(
              message: 'Response status code: ${response.statusCode}');
        }
      }
    } catch (error) {
      throw error;
    }
  }

  Future<CodeValidationResult> validateMobileValidationCode(
      String smsCodeValue) async {
    var validateMobileValidationCodeUri = Uri.https(
        _environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) +
            '/validation-codes/sms/validate');

    try {
      final response = await http.post(validateMobileValidationCodeUri,
          headers: {
            HttpHeaders.authorizationHeader:
                "Bearer ${_authenticationService.token!}",
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: json.encode({'code': smsCodeValue}));

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
            throw MobileValidationApiException(message: errorMessage);
          } else {
            throw MobileValidationApiException(
                message: 'Response status code: ${response.statusCode}');
          }
        } else {
          throw MobileValidationApiException(
              message: 'Response status code: ${response.statusCode}');
        }
      }

      return CodeValidationResult.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } catch (error) {
      throw error;
    }
  }
}
