import 'package:fretto/api/discussion_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/models/discussion.dart';
import 'package:fretto/models/discussions_result.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class DiscussionService with ReactiveServiceMixin {
  DiscussionService() {
    listenToReactiveValues([_missedMessages, _discussions]);
  }
  Logger log = getLogger('DiscussionService');
  DiscussionApi _discussionApi = locator<DiscussionApi>();
  ReactiveList<Discussion> _discussions = ReactiveList<Discussion>();
  ReactiveValue<int> _missedMessages = ReactiveValue<int>(0);

  DiscussionsResult? _discussionsResult;

  int _pageSize = 10;

  int get missedMessages => _missedMessages.value;

  ReactiveList<Discussion> get discussions => _discussions;

  DiscussionsResult? get discussionsResult => _discussionsResult;

  int get pageSize => _pageSize;

  Future<void> fetchFirstDiscussionsResult() async {
    _discussionsResult =
        await _discussionApi.fetchDiscussionsResult(0, _pageSize);
    _discussions.assignAll(_discussionsResult!.discussions);
  }

  Future<void> fetchNextDiscussionsResult() async {
    if (_discussionsResult != null && _discussionsResult!.hasNext) {
      _discussionsResult = await _discussionApi.fetchDiscussionsResult(
          _discussionsResult!.pageNumber + 1, _pageSize);
      _discussions.addAll(_discussionsResult!.discussions);
    }
  }

  void incrementMissedMessages() {
    _missedMessages.value++;
  }

  void decrementMissedMessages(int decrementBy) {
    _missedMessages.value -= decrementBy;
  }

  Future<Discussion?> fetchDiscussionByClientIdAndTransporterId(
      int clientId, int transporterId) async {
    return _discussionApi.findDiscussionByClientIdAndTransporterId(
        clientId, transporterId);
  }

  Future<Discussion?> fetchDiscussionById(int discussionId) async {
    return _discussionApi.findDiscussionById(discussionId);
  }

  void addDiscussionToTop(Discussion discussion) {
    _discussions.insert(0, discussion);
  }

  void removeDiscussion(Discussion discussion) {
    _discussions.remove(discussion);
  }

  Discussion? findDiscussionById(int discussionId) {
    try {
      return _discussions.firstWhere((d) => d.id == discussionId);
    } catch (StateError) {
      return null;
    }
  }

  void removeDiscussionFromBottom() {
    _discussions.removeLast();
  }

/*   void updateLatestMessage(int? discussionId, Message message) {
    try {
      Discussion discussion =
          _discussions.firstWhere((d) => d.id == discussionId);
      discussion.latestMessage = message;
      _discussions.insert(
          _discussions.indexWhere((d) => d.id == discussionId), discussion);
    } catch (StateError) {
      return;
    }
  } */
}
