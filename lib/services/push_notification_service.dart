import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fretto/api/device_token_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/models/discussion.dart';
import 'package:fretto/models/message.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/ui/views/home/home_viewmodel.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import 'discussion_service.dart';
import 'messaging_service.dart';

class PushNotificationService {
  Logger log = getLogger('PushNotificationService');
  NavigationService _navigationService = locator<NavigationService>();
  DiscussionService _discussionService = locator<DiscussionService>();
  MessagingService _messagingService = locator<MessagingService>();

  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  DeviceTokenApi _deviceTokenApi = locator<DeviceTokenApi>();

  HomeViewModel homeViewModel = locator<HomeViewModel>();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  String? _token;

  late Stream<String> _tokenStream;

  String? get deviceToken => _token;

  Future initialize() async {
    if (Platform.isIOS) {
      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        return;
      }
    }
    _token = await _fcm.getToken();

    print("DEVICE TOKEN:==> " + _token!);

    _tokenStream = _fcm.onTokenRefresh;
    _tokenStream.listen(saveDeviceTokenToBackend);

    //handle messages which caused app to open a terminated state
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();

    if (initialMessage != null) {
      print("received a message when app terminated $initialMessage");
      _handleTerminatedMessage(initialMessage);
    }

    //handle messages coming from interaction while the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    //handle messages when app is in the foreground state
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
  }

  Future<void> saveDeviceTokenToBackend(String deviceToken) async {
    _deviceTokenApi.saveDeviceToken(deviceToken);
  }

  Future<void> saveRegistredDeviceTokenToBackend() async {
    if (_token != null) {
      await _deviceTokenApi.saveDeviceToken(_token!);
    }
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    print("received foreground message $message");

    if (_authenticationService.isAuthenticated) {
      Map<String, dynamic> data = message.data;

      String? type = data['type'];

      switch (type) {
        case 'discussion':
          Discussion newDiscussion =
              Discussion.fromJson(json.decode(data['content']));

          if (_discussionService.discussionsResult!.hasNext) {
            _discussionService.removeDiscussionFromBottom();
          }
          _discussionService.addDiscussionToTop(newDiscussion);

          _discussionService.incrementMissedMessages();
          break;

        case 'message':
          Map<String, dynamic> content = json.decode(data["content"]);

          Message message = Message.fromJson(content["message"]);

          int discussionId = content["discussionId"];

          if (_navigationService.currentRoute == Routes.messagingView &&
              _navigationService.currentArguments is MessagingViewArguments &&
              discussionId ==
                  (_navigationService.currentArguments
                          as MessagingViewArguments)
                      .discussionId) {
            //if discussion is opened

            if (_messagingService.discussionMessagesResult!.hasNext) {
              _messagingService.removeMessageFromBottom();
            }
            _messagingService.addMessageToTop(message);
          } else if ((_navigationService.currentRoute == Routes.homeView ||
                  _navigationService.currentRoute == "") &&
              homeViewModel.currentIndex == 2) {
            //if discussion is closed
            Discussion? discussion =
                _discussionService.findDiscussionById(discussionId);

            if (discussion != null) {
              _discussionService.removeDiscussion(discussion);
            } else {
              discussion =
                  await _discussionService.fetchDiscussionById(discussionId);
              _discussionService.removeDiscussionFromBottom();
            }

            discussion!.latestMessage = message;

            _discussionService.addDiscussionToTop(discussion);

            _discussionService.incrementMissedMessages();
          } else {
            _discussionService.incrementMissedMessages();
          }

          break;

        case 'journey':
          break;

        case 'proposal':
          break;

        default:
      }
    }
  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    print("received Background message $message");
    Map<String, dynamic> data = message.data;

    String? type = data['type'];

    switch (type) {
      case 'discussion':
        if (_authenticationService.isAuthenticated) {
          _navigationService.navigateTo(Routes.homeView,
              arguments: HomeViewArguments(viewIndex: 2));
          Discussion newDiscussion =
              Discussion.fromJson(json.decode(data['content']));

          if (_discussionService.discussionsResult!.hasNext) {
            _discussionService.removeDiscussionFromBottom();
          }
          _discussionService.addDiscussionToTop(newDiscussion);

          _discussionService.incrementMissedMessages();
        } else {
          _navigationService.replaceWith(Routes.authenticationChoiceView);
        }
        break;

      default:
    }
  }

  Future<void> _handleTerminatedMessage(RemoteMessage message) async {
    print("received Terminated message $message");
    Map<String, dynamic> data = message.data;

    String? type = data['type'];

    switch (type) {
      case 'discussion':
        if (await _authenticationService.tryAutoLogin()) {
          _navigationService.navigateTo(Routes.homeView,
              arguments: HomeViewArguments(viewIndex: 2));
        } else {
          _navigationService.replaceWith(Routes.authenticationChoiceView);
        }
        break;

      default:
    }
  }
}
