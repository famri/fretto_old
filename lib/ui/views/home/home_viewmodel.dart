import 'package:fretto/app/app.locator.dart';
import 'package:fretto/services/discussion_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends IndexTrackingViewModel {
  DiscussionService _discussionService = locator<DiscussionService>();
  @override
  List<ReactiveServiceMixin> get reactiveServices => [_discussionService];

  int getMissedMessagesCount() {
    return _discussionService.missedMessages;
  }
}
