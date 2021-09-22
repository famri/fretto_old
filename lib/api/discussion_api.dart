import 'dart:convert';
import 'dart:io';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/discussion_api_exception.dart';
import 'package:fretto/models/discussion.dart';
import 'package:fretto/models/discussions_result.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:http/http.dart' as http;

class DiscussionApi {
  final log = getLogger('DiscussionApi');
  final EnvironmentService _environmentService = locator<EnvironmentService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<DiscussionsResult> fetchDiscussionsResult(
      int pageNumber, int size) async {
    var queryParams = {'page': pageNumber.toString(), 'size': size.toString()};
    var discussionsUri = Uri.https(
        _environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/users/me/discussions',
        queryParams);

    try {
      final response = await http.get(
        discussionsUri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${_authenticationService.token!}",
          HttpHeaders.contentTypeHeader: "application/json"
        },
      );

      if (response.statusCode != 200) {
        if (response.body.isNotEmpty &&
            json.decode(response.body)['errors'] != null) {
          var errorsList = json.decode(response.body)['errors'];
          var strBuffer = StringBuffer();
          errorsList.forEach((item) {
            strBuffer.write(item);
            strBuffer.write(', ');
          });
          String errorMessage = strBuffer
              .toString()
              .substring(0, strBuffer.toString().length - 2);
          throw DiscussionApiException(message: errorMessage);
        } else {
          throw DiscussionApiException(
              message:
                  'Received status code:' + response.statusCode.toString());
        }
      }

      DiscussionsResult result = DiscussionsResult.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
      return result;
    } catch (error) {
      throw error;
    }
  }

  Future<Discussion?> findDiscussionByClientIdAndTransporterId(
      int clientId, int transporterId) async {
    var queryParams = {
      'clientId': clientId.toString(),
      'transporterId': transporterId.toString()
    };
    var discussionsUri = Uri.https(
        _environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/users/me/discussions',
        queryParams);

    try {
      final response = await http.get(
        discussionsUri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${_authenticationService.token!}",
          HttpHeaders.contentTypeHeader: "application/json"
        },
      );

      if (response.statusCode != 200) {
        if (response.statusCode == 404) {
          return null;
        }
        if (response.body.isNotEmpty &&
            json.decode(response.body)['errors'] != null) {
          var errorsList = json.decode(response.body)['errors'];
          var strBuffer = StringBuffer();
          errorsList.forEach((item) {
            strBuffer.write(item);
            strBuffer.write(', ');
          });
          String errorMessage = strBuffer
              .toString()
              .substring(0, strBuffer.toString().length - 2);
          throw DiscussionApiException(message: errorMessage);
        } else {
          throw DiscussionApiException(
              message:
                  'Received status code:' + response.statusCode.toString());
        }
      }

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      Discussion foundDiscussions = Discussion.fromJson(extractedData);

      return foundDiscussions;
    } catch (error) {
      throw error;
    }
  }

  Future<Discussion?> findDiscussionById(int discussionId) async {
    var discussionsUri = Uri.https(
        _environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) +
            '/users/me/discussions/$discussionId');

    try {
      final response = await http.get(
        discussionsUri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${_authenticationService.token!}",
          HttpHeaders.contentTypeHeader: "application/json"
        },
      );

      if (response.statusCode != 200) {
        if (response.statusCode == 404) {
          return null;
        }
        if (response.body.isNotEmpty &&
            json.decode(response.body)['errors'] != null) {
          var errorsList = json.decode(response.body)['errors'];
          var strBuffer = StringBuffer();
          errorsList.forEach((item) {
            strBuffer.write(item);
            strBuffer.write(', ');
          });
          String errorMessage = strBuffer
              .toString()
              .substring(0, strBuffer.toString().length - 2);
          throw DiscussionApiException(message: errorMessage);
        } else {
          throw DiscussionApiException(
              message:
                  'Received status code:' + response.statusCode.toString());
        }
      }

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      Discussion foundDiscussions = Discussion.fromJson(extractedData);

      return foundDiscussions;
    } catch (error) {
      throw error;
    }
  }

  Future<Discussion> createDiscussion(int clientId, int transporterId) async {
    var discussionsUri = Uri.https(_environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) + '/users/me/discussions');

    Map<String, String> requestBody = {
      'clientId': clientId.toString(),
      'transporterId': transporterId.toString()
    };

    try {
      final response = await http.post(discussionsUri,
          headers: {
            HttpHeaders.authorizationHeader:
                "Bearer ${_authenticationService.token!}",
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: jsonEncode(requestBody));

      if (response.statusCode != 201) {
        if (response.body.isNotEmpty &&
            json.decode(response.body)['errors'] != null) {
          var errorsList = json.decode(response.body)['errors'];
          var strBuffer = StringBuffer();
          errorsList.forEach((item) {
            strBuffer.write(item);
            strBuffer.write(', ');
          });
          String errorMessage = strBuffer
              .toString()
              .substring(0, strBuffer.toString().length - 2);
          throw DiscussionApiException(message: errorMessage);
        } else {
          throw DiscussionApiException(
              message:
                  'Received status code:' + response.statusCode.toString());
        }
      }

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      Discussion createdDiscussions = Discussion.fromJson(extractedData);

      return createdDiscussions;
    } catch (error) {
      throw error;
    }
  }
}
