import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/models/discussion_messages_result.dart';
import 'package:fretto/models/message.dart';
import 'package:fretto/services/application_settings_service.dart';
import 'package:fretto/services/messaging_service.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class MessagingViewModel extends ReactiveViewModel {
  final ApplicationSettingsService _applicationSettingsService =
      locator<ApplicationSettingsService>();

  final MessagingService _messagingService = locator<MessagingService>();

  bool? nextPage;

  ScrollController _scrollController = ScrollController();

  DiscussionMessagesResult? _messagesResult;

  int _showMessageDateTimeIndex = -1;

  TextEditingController? _messageTextController;

  DateFormat? dateTimeFormat;

  int? _discussionId;

  int get showMessageDateTimeIndex => _showMessageDateTimeIndex;

  ScrollController? get scrollController => _scrollController;

  TextEditingController? get messageTextController => _messageTextController;

  DiscussionMessagesResult? get discussionMessagesResult => _messagesResult;

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

    _messagesResult = await _messagingService.fetchDiscussionMessagesResult(
        discussionId, 0, 10);
    _messagingService.resetMessages();
    _messagingService.addAllMessages(_messagesResult!.messages);
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
        .then((value) => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 50,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut));
  }

  Future<void> fetchDiscussionMessagesResult() async {
    _messagingService
        .fetchDiscussionMessagesResult(
            _discussionId!, _messagesResult!.pageNumber + 1, 10)
        .then((value) {
      _messagesResult = value;
      _messagingService.addAllMessages(_messagesResult!.messages);
    });
  }
}
