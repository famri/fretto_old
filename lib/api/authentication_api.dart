import 'dart:convert';
import 'dart:io';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/authentication_api_exception.dart';
import 'package:fretto/models/bearer_token_info.dart';
import 'package:fretto/models/user_info.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:http/http.dart' as http;

class AuthenticationApi {
  final EnvironmentService _environmentService = locator<EnvironmentService>();

  Future<BearerTokenInfo> signup(
      String email,
      String icc,
      String mobileNumber,
      String userPassword,
      bool isTransporter,
      int gender,
      String firstname,
      String lastname,
      DateTime dateOfBirth,
      bool receiveNewsletter) async {
    final Uri signupUri = Uri.https(_environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/accounts');
    try {
      final response = await http.post(signupUri,
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: json.encode({
            "isTransporter": isTransporter,
            "genderId": gender,
            "firstname": firstname,
            "lastname": lastname,
            "dateOfBirth": dateOfBirth.toIso8601String(),
            "email": email,
            "icc": icc,
            "mobileNumber": mobileNumber,
            "userPassword": userPassword,
            "receiveNewsletter": receiveNewsletter
          }));

      final responseData = json.decode(response.body);
      if (response.statusCode != 201) {
        if (response.body.isNotEmpty) {
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
            throw AuthenticationApiException(message: errorMessage);
          }
          throw AuthenticationApiException(
              message:
                  'Received status code:' + response.statusCode.toString());
        } else {
          throw AuthenticationApiException(
              message:
                  'Received status code:' + response.statusCode.toString());
        }
      }

      return BearerTokenInfo(
          token: responseData['access_token'],
          refreshToken: responseData['refresh_token'],
          expiryDate: DateTime.now().add(Duration(
            seconds: int.parse(responseData['expires_in'].toString()),
          )));
    } catch (error) {
      throw error;
    }
  }

  Future<BearerTokenInfo> signin(
      String emailOrFullMobileNumber, String password) async {
    final Uri loginUri = Uri.https(_environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/login');
    try {
      final response = await http.post(loginUri,
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
          body: json.encode(
              {"username": emailOrFullMobileNumber, "password": password}));

      final responseData = json.decode(response.body);

      if (response.statusCode != 200) {
        if (response.body.isNotEmpty &&
            json.decode(response.body)['errors'] != null) {
          var errorsList = responseData['errors'];
          var strBuffer = StringBuffer();
          errorsList.forEach((item) {
            strBuffer.write(item);
            strBuffer.write(', ');
          });
          String errorMessage = strBuffer
              .toString()
              .substring(0, strBuffer.toString().length - 2);
          throw AuthenticationApiException(message: errorMessage);
        } else {
          throw AuthenticationApiException(
              message:
                  'Received status code:' + response.statusCode.toString());
        }
      }

      return BearerTokenInfo(
          token: responseData['access_token'],
          refreshToken: responseData['refresh_token'],
          expiryDate: DateTime.now().add(Duration(
            seconds: int.parse(responseData['expires_in'].toString()),
          )));
    } catch (error) {
      throw error;
    }
  }

  Future<UserInfo> checkAccessToken(String token) async {
    final queryParameters = {'token': token};
    final checkTokenUri = Uri.https(_environmentService.getValue(AppDomain),
        '/oauth/check_token', queryParameters);

    final checkTokenResponse = await http.get(checkTokenUri);

    final checkTokenResponseData = json.decode(checkTokenResponse.body);
    if (checkTokenResponse.statusCode != 200) {
      if (checkTokenResponse.body.isNotEmpty &&
          checkTokenResponseData['error_description'] != null) {
        String errorMessage = checkTokenResponseData['error_description'];
        throw AuthenticationApiException(message: errorMessage);
      } else {
        throw AuthenticationApiException(
            message: 'Received status code:' +
                checkTokenResponse.statusCode.toString());
      }
    }

    return UserInfo(
        id: checkTokenResponseData['user_id'],
        username: checkTokenResponseData['sub'],
        authorities: checkTokenResponseData['authorities'].cast<String>());
  }
}
