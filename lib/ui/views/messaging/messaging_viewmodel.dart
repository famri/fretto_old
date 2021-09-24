import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/models/discussion_messages_result.dart';
import 'package:fretto/models/message.dart';
import 'package:fretto/services/application_settings_service.dart';
import 'package:fretto/services/discussion_service.dart';
import 'package:fretto/services/messaging_service.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class MessagingViewModel extends ReactiveViewModel {
  final ApplicationSettingsService _applicationSettingsService =
      locator<ApplicationSettingsService>();

  final MessagingService _messagingService = locator<MessagingService>();
  final DiscussionService _discussionService = locator<DiscussionService>();
  bool? nextPage;

  ScrollController _scrollController = ScrollController();

  int _showMessageDateTimeIndex = -1;

  TextEditingController? _messageTextController;

  DateFormat? dateTimeFormat;

  int? _discussionId;

  int get showMessageDateTimeIndex => _showMessageDateTimeIndex;

  ScrollController? get scrollController => _scrollController;

  TextEditingController? get messageTextController => _messageTextController;

  DiscussionMessagesResult? get discussionMessagesResult =>
      _messagingService.discussionMessagesResult;

  List<Message> get messages => _messagingService.messages;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_messagingService];

  Future<void> initialize(int discussionId) async {
    await runBusyFuture(_initialize(discussionId));
  }

  Future<void> _initialize(int discussionId) async {
    _discussionId = discussionId;
    String userLocale =
        _applicationSettingsService.applicationSettings!.userLocaleCountry +
            '_' +
            _applicationSettingsService.applicationSettings!.userLocaleLanguage;
    dateTimeFormat = DateFormat.MMMMd(userLocale).add_Hm();

    _messageTextController = TextEditingController();

    await _messagingService.fetchFirstDiscussionMessagesResult(discussionId);
  }

  void switchShowMessageDateTime(int reversedIndex) {
    if (_showMessageDateTimeIndex == reversedIndex) {
      _showMessageDateTimeIndex = -1;
    } else {
      _showMessageDateTimeIndex = reversedIndex;
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _messageTextController!.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    _messagingService
        .sendMessage(_discussionId!, _messageTextController!.text)
        .then((value) {
      if (_messagingService.discussionMessagesResult != null &&
          _messagingService.discussionMessagesResult!.hasNext) {
        _messagingService.removeMessageFromBottom();
      }
      _messagingService.addMessageToTop(value);
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 50,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut);
      _messageTextController!.text = '';
    });
  }

  Future<void> fetchNextDiscussionMessagesResult() async {
    _messagingService.fetchNextDiscussionMessagesResult(_discussionId!);
  }
}
