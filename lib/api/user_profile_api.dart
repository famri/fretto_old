import 'dart:convert';
import 'dart:io';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/user_profile_api_exception.dart';
import 'package:fretto/models/user_profile_info.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:http/http.dart' as http;

class UserProfileApi {
  final log = getLogger('UserProfileApi');
  final EnvironmentService _environmentService = locator<EnvironmentService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<UserProfileInfo> fetchUserProfileInfo(String locale) async {
    var queryParams = {"lang": locale};

    var userProfileInfoUri = Uri.https(
        _environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/profiles/me/info',
        queryParams);

    try {
      final response = await http.get(
        userProfileInfoUri,
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
          throw UserProfileApiException(message: errorMessage);
        } else {
          throw UserProfileApiException(
              message: 'Response status code: ${response.statusCode}');
        }
      }

      responseData = json.decode(response.body);
      return UserProfileInfo.fromJson(responseData as Map<String, dynamic>);
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateMobileInfo(int iccId, String mobileNumberValue) async {
    var userProfileInfoUri = Uri.https(_environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/profiles/me/mobile');

    try {
      final response = await http.patch(userProfileInfoUri,
          headers: {
            HttpHeaders.authorizationHeader:
                "Bearer ${_authenticationService.token!}",
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body:
              json.encode({'iccId': iccId, 'mobileNumber': mobileNumberValue}));

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
          throw UserProfileApiException(message: errorMessage);
        } else {
          throw UserProfileApiException(
              message: 'Response status code: ${response.statusCode}');
        }
      }
    } catch (error) {
      throw error;
    }
  }
}
