import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/models/discussion.dart';
import 'package:fretto/models/discussions_result.dart';
import 'package:fretto/services/discussion_service.dart';
import 'package:stacked/stacked.dart';

class DiscussionsViewModel extends ReactiveViewModel {
  DiscussionService _discussionService = locator<DiscussionService>();

  List<Discussion> get discussions => _discussionService.discussions.toList();

  DiscussionsResult? discussionsResult;
  ScrollController? _scrollController;
  ScrollController? get scrollController => _scrollController;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_discussionService];

  get isClient => true;

  void _scrollListener() {
    if (discussionsResult!.hasNext &&
        _scrollController!.offset >=
            _scrollController!.position.maxScrollExtent &&
        !_scrollController!.position.outOfRange) {
      //fetch next page
      _discussionService
          .fetchDiscussionsResult(discussionsResult!.pageNumber + 1, 10)
          .then((value) {
        discussionsResult = value;
        _discussionService.addAllDiscussions(discussionsResult!.discussions);
        notifyListeners();
      });
    }
  }

  showMessages(discussion) {}

  Future<void> initialize() async {
    print('initializing discussion view model');
    await runBusyFuture(_initialize());
  }

  Future<void> _initialize() async {
    discussionsResult = await _discussionService.fetchDiscussionsResult(0, 10);

    _discussionService.discussions.addAll(discussionsResult!.discussions);

    _scrollController = ScrollController()..addListener(_scrollListener);
  }
}
