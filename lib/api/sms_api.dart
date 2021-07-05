import 'dart:convert';
import 'dart:io';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/sms_api_exception.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:http/http.dart' as http;

class SMSApi {
  final log = getLogger('SMSApi');
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
          throw SMSApiException(message: errorMessage);
        } else {
          throw SMSApiException(
              message: 'Response status code: ${response.statusCode}');
        }
      }
    } catch (error) {
      throw error;
    }
  }
}
