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

  ReactiveList<Message> get messages => _messages;

  void addAllMessages(List<Message> messages) {
    _messages.addAll(messages);
  }

  Future<DiscussionMessagesResult> fetchDiscussionMessagesResult(
      int discussionId, int pageNumber, int pageSize) async {
    return _messagingApi.fetchDiscussionMessages(
        discussionId, pageNumber, pageSize);
  }

  Future<void> sendMessage(int discussionId, String messageContent) async {
    _messagingApi.sendMessage(discussionId, messageContent).then((value) =>
        fetchDiscussionMessagesResult(discussionId, 0, 1).then((value) =>
            _messages.assignAll([value.messages.first, ..._messages])));
  }

  void resetMessages() {
    _messages.assignAll([]);
  }
}
