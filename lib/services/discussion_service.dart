import 'package:fretto/api/discussion_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/models/discussion.dart';
import 'package:fretto/models/discussions_result.dart';
import 'package:fretto/models/message.dart';
import 'package:logger/logger.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

class DiscussionService with ReactiveServiceMixin {
  DiscussionService() {
    listenToReactiveValues([_missedMessages, _discussions]);
  }
  Logger log = getLogger('DiscussionService');
  DiscussionApi _discussionApi = locator<DiscussionApi>();
  ReactiveList<Discussion> _discussions = ReactiveList<Discussion>();
  RxValue<int> _missedMessages = RxValue<int>(0);
  Discussion? _currentDiscussion;

  int get missedMessages => _missedMessages.value;
  ReactiveList<Discussion> get discussions => _discussions;

  Discussion? get currentDiscussion => _currentDiscussion;
  ReactiveList<List<Message>> _currentDiscussionMessages =
      ReactiveList<List<Message>>();

  Future<DiscussionsResult> fetchDiscussionsResult(
      int pageNumber, int size) async {
    return _discussionApi.fetchDiscussionsResult(pageNumber, size);
  }

  void addMessageToDiscussion(int discussionId, Message message) {
    _discussions
        .toList()
        .firstWhere((element) => element.id == discussionId)
        .latestMessage = message;
  }

  void incrementMissedMessages() {
    _missedMessages.value++;
  }

  void decrementMissedMessages(int decrementBy) {
    _missedMessages.value -= decrementBy;
  }

  void addAllDiscussions(discussions) {}

  Future<Discussion?> findDiscussion(int clientId, int transporterId) async {
    return _discussionApi.findDiscussion(clientId, transporterId);
  }

  void addDiscussionToTop(Discussion? discussion) {
    if (_discussions.isNotEmpty && _discussions.length >= 10) {
      _discussions.removeLast();
    }
    _discussions.assignAll([discussion!, ..._discussions.toList()]);
  }
}
