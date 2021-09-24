import 'package:fretto/api/messaging_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/models/discussion_messages_result.dart';
import 'package:fretto/models/message.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class MessagingService with ReactiveServiceMixin {
  MessagingService() {
    listenToReactiveValues([_messages]);
  }

  Logger log = getLogger('MessagingService');

  MessagingApi _messagingApi = locator<MessagingApi>();

  ReactiveList<Message> _messages = ReactiveList<Message>();

  DiscussionMessagesResult? _discussionMessagesResult;

  ReactiveList<Message> get messages => _messages;

  DiscussionMessagesResult? get discussionMessagesResult =>
      _discussionMessagesResult;

  int _pageSize = 10;
  int get pageSize => _pageSize;

  Future<void> fetchFirstDiscussionMessagesResult(int discussionId) async {
    _messagingApi
        .fetchDiscussionMessages(discussionId, 0, _pageSize)
        .then((value) {
      _discussionMessagesResult = value;
      _messages.assignAll(value.messages);
    });
  }

  Future<Message> sendMessage(int discussionId, String messageContent) async {
    return _messagingApi.sendMessage(discussionId, messageContent);
  }

  Future<void> fetchNextDiscussionMessagesResult(int discussionId) async {
    if (_discussionMessagesResult != null &&
        _discussionMessagesResult!.hasNext) {
      _messagingApi
          .fetchDiscussionMessages(discussionId,
              _discussionMessagesResult!.pageNumber + 1, _pageSize)
          .then((value) {
        _discussionMessagesResult = value;
        _messages.addAll(value.messages);
      });
    }
  }

  void removeMessageFromBottom() {
    _messages.removeLast();
  }

  void addMessageToTop(Message message) {
    _messages.insert(0, message);
  }
}
