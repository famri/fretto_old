import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/models/discussion.dart';
import 'package:fretto/models/discussions_result.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/discussion_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DiscussionsViewModel extends ReactiveViewModel {
  DiscussionService _discussionService = locator<DiscussionService>();
  NavigationService _navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  List<Discussion> get discussions => _discussionService.discussions.toList();

  DiscussionsResult? discussionsResult;
  ScrollController? _scrollController;
  ScrollController? get scrollController => _scrollController;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_discussionService];

  get isClient => true;

  Future<void> navigateToMessages(Discussion discussion) async {
    _navigationService
        .navigateTo(Routes.messagingView,
            arguments: MessagingViewArguments(
                interlocutor: _authenticationService.isClient
                    ? discussion.transporter
                    : discussion.client,
                discussionId: discussion.id))!
        .then((_) => initialize());
  }

  Future<void> initialize() async {
    print('initializing discussion view model');
    await runBusyFuture(_initialize());
  }

  Future<void> _initialize() async {
    await _discussionService.fetchFirstDiscussionsResult();
  }

  Future<void> fetchNextDiscussionsResult() async {
    await _discussionService.fetchNextDiscussionsResult();
  }

  @override
  void dispose() {
    if (_scrollController != null) {
      _scrollController!.dispose();
    }
    super.dispose();
  }
}
