import 'dart:convert';
import 'dart:io';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/messaging_api_exception.dart';
import 'package:fretto/models/discussion_messages_result.dart';
import 'package:fretto/models/gender.dart';
import 'package:fretto/models/message.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:http/http.dart' as http;

class MessagingApi {
  final log = getLogger('MessagingApi');
  final EnvironmentService _environmentService = locator<EnvironmentService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<DiscussionMessagesResult> fetchDiscussionMessages(
      int discussionId, int pageNumber, int size) async {
    var queryParams = {'page': pageNumber.toString(), 'size': size.toString()};
    var discussionMessagesUri = Uri.https(
        _environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) +
            '/users/me/discussions/$discussionId/messages',
        queryParams);

    try {
      final response = await http.get(
        discussionMessagesUri,
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
          throw MessagingApiException(message: errorMessage);
        } else {
          throw MessagingApiException(
              message:
                  'Received status code:' + response.statusCode.toString());
        }
      }

      DiscussionMessagesResult result = DiscussionMessagesResult.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
      return result;
    } catch (error) {
      throw error;
    }
  }

  Future<Message> sendMessage(int discussionId, String messageContent) async {
    var saveMessageUri = Uri.https(
        _environmentService.getValue(AppDomain),
        _environmentService.getValue(AppName) +
            '/users/me/discussions/$discussionId/messages');

    Map<String, String> requestBody = {"content": messageContent};

    try {
      final response = await http.post(
        saveMessageUri,
        headers: {
          HttpHeaders.authorizationHeader:
              "Bearer ${_authenticationService.token!}",
          HttpHeaders.contentTypeHeader: "application/json"
        },
        body: jsonEncode(requestBody),
      );

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
          throw MessagingApiException(message: errorMessage);
        } else {
          throw MessagingApiException(
              message:
                  'Received status code:' + response.statusCode.toString());
        }
      }

      var responseData = json.decode(response.body);

      final extractedData = responseData as Map<String, dynamic>;

      return Message.fromJson(extractedData);
    } catch (error) {
      throw error;
    }
  }
}
