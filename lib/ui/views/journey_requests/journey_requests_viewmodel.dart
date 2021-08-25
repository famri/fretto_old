import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/models/client_journey_request_dto.dart';
import 'package:fretto/models/client_journey_requests_result.dart';
import 'package:fretto/services/application_settings_service.dart';
import 'package:fretto/services/journey_request_service.dart';
import 'package:fretto/ui/shared/snackbar_type.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class JourneyRequestsViewModel extends BaseViewModel {
  final ApplicationSettingsService _applicationSettingsService =
      locator<ApplicationSettingsService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final JourneyRequestService _journeyRequestService =
      locator<JourneyRequestService>();

  List<SortingCriterion> sortingCriteria = [
    SortingCriterion(
        AppLocalizationDelegate.appLocalizations!.clientJourneysSortDateAsc,
        'date-time,asc',
        Icon(
          Icons.arrow_upward_outlined,
          color: Colors.blue,
        )),
    SortingCriterion(
        AppLocalizationDelegate.appLocalizations!.clientJourneysSortDateDesc,
        'date-time,desc',
        Icon(
          Icons.arrow_downward_outlined,
          color: Colors.blue,
        ))
  ];
  List<FilteringCriterion> filteringCriteria = [
    FilteringCriterion(
        AppLocalizationDelegate.appLocalizations!.clientJourneysFilterLastWeek,
        'w1'),
    FilteringCriterion(
        AppLocalizationDelegate.appLocalizations!.clientJourneysFilterLastMonth,
        'm1'),
    FilteringCriterion(
        AppLocalizationDelegate
            .appLocalizations!.clientJourneysFilterLastQuarter,
        'm3'),
    FilteringCriterion(
        AppLocalizationDelegate
            .appLocalizations!.clientJourneysFilterLastSemester,
        'm6'),
    FilteringCriterion(
        AppLocalizationDelegate.appLocalizations!.clientJourneysFilterLastYear,
        'y1'),
  ];

  String sortingValue = 'date-time,desc';

  String filteringValue = 'm1';

  List<ClientJourneyRequestDto> _journeyRequests = [];

  List<ClientJourneyRequestDto> get journeyRequests => _journeyRequests;

  ClientJourneyRequestsResult? clientJourneyRequestsResult;
  DateFormat? dateFormatter;
  ScrollController? _scrollController;
  ScrollController? get scrollController => _scrollController;

  Future<void> initialize() async {
    await runBusyFuture(_initialize());
  }

  void _scrollListener() {
    if (clientJourneyRequestsResult!.hasNext &&
        _scrollController!.offset >=
            _scrollController!.position.maxScrollExtent &&
        !_scrollController!.position.outOfRange) {
      _journeyRequestService
          .fetchClientJourneyRequestsResult(
              filteringValue,
              clientJourneyRequestsResult!.pageNumber + 1,
              5,
              sortingValue,
              _applicationSettingsService
                  .applicationSettings!.userLocaleLanguage,
              _applicationSettingsService
                  .applicationSettings!.userLocaleCountry)
          .then((value) {
        clientJourneyRequestsResult = value;
        _journeyRequests.addAll(clientJourneyRequestsResult!.journeyRequests);
        notifyListeners();
      });
    }
  }

  Future<void> _initialize() async {
    clientJourneyRequestsResult =
        await _journeyRequestService.fetchClientJourneyRequestsResult(
            filteringValue,
            0,
            5,
            sortingValue,
            _applicationSettingsService.applicationSettings!.userLocaleLanguage,
            _applicationSettingsService.applicationSettings!.userLocaleCountry);

    _journeyRequests = clientJourneyRequestsResult!.journeyRequests;

    dateFormatter = DateFormat(
        'EEE dd/MM/yyyy HH:mm',
        _applicationSettingsService.applicationSettings!.userLocaleLanguage +
            '_' +
            _applicationSettingsService.applicationSettings!.userLocaleCountry);
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  Future<void> fetchAndSetClientJourneyRequests() async {
    setBusy(true);
    clientJourneyRequestsResult =
        await _journeyRequestService.fetchClientJourneyRequestsResult(
            filteringValue,
            0,
            5,
            sortingValue,
            _applicationSettingsService.applicationSettings!.userLocaleLanguage,
            _applicationSettingsService.applicationSettings!.userLocaleCountry);

    _journeyRequests = clientJourneyRequestsResult!.journeyRequests;

    setBusy(false);
  }

  showDeleteJourneyWarning(BuildContext context, int id) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              AppLocalizations.of(context)!.deleteJourneyRequestWarningTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppLocalizations.of(context)!
                    .deleteJourneyRequestWarningText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:
                  Text(MaterialLocalizations.of(context).continueButtonLabel),
              onPressed: () {
                Navigator.of(context).pop();
                runBusyFuture(
                    _journeyRequestService.cancelJourneyRequest(id).then((_) {
                  _journeyRequests.removeWhere((element) => element.id == id);
                  _showSuccessSnackbar(AppLocalizationDelegate
                      .appLocalizations!.deleteJourneyRequestSuccessMessage);
                }));
              },
            ),
            TextButton(
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void onFutureError(dynamic error, Object? key) {
    if (error is SocketException) {
      if (error.message == 'Connection failed') {
        _showErrorSnackbar(
            AppLocalizationDelegate.appLocalizations!.checkYourConnectionText);
      } else {
        _showErrorSnackbar(
            AppLocalizationDelegate.appLocalizations!.somethingWentWrongText);
      }
    } else {
      _showErrorSnackbar(
          AppLocalizationDelegate.appLocalizations!.somethingWentWrongText);
    }
  }

  void _showErrorSnackbar(String message) {
    _snackbarService.showCustomSnackBar(
      variant: SnackbarType.error,
      message: message,
      duration: Duration(seconds: 3),
    );
  }

  void _showSuccessSnackbar(String message) {
    _snackbarService.showCustomSnackBar(
      variant: SnackbarType.success,
      message: message,
      duration: Duration(seconds: 3),
    );
  }

  navigateToJourneyDetails(int index) {
    _navigationService
        .navigateTo(Routes.journeyDetailsView,
            arguments: JourneyDetailsViewArguments(
                journeyRequest: _journeyRequests[index]))!
        .then((_) => fetchAndSetClientJourneyRequests());
  }

  void navigateToJourneyProposals(int index) {
    _navigationService.navigateTo(Routes.journeyProposalsView,
        arguments: JourneyProposalsViewArguments(
            journeyId: _journeyRequests[index].id));
  }
}

class SortingCriterion {
  final String name;
  final String value;
  final Icon icon;
  SortingCriterion(this.name, this.value, this.icon);
}

class FilteringCriterion {
  final String name;
  final String value;

  FilteringCriterion(this.name, this.value);
}
