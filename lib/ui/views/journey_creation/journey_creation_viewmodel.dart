import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/exceptions/api_error_code.dart';
import 'package:fretto/exceptions/mobile_validation_exception.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/models/engine_type.dart';
import 'package:fretto/services/application_settings_service.dart';
import 'package:fretto/services/engine_type_service.dart';
import 'package:fretto/services/journey_request_service.dart';
import 'package:fretto/ui/shared/bottom_sheet_type.dart';
import 'package:fretto/ui/shared/snackbar_type.dart';
import 'package:fretto/ui/views/journey_creation/journey_creation_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class JourneyCreationViewModel extends FormViewModel {
  final EngineTypeService _engineTypeService = locator<EngineTypeService>();
  final ApplicationSettingsService _applicationSettingsService =
      locator<ApplicationSettingsService>();
  final JourneyRequestService _journeyRequestService =
      locator<JourneyRequestService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BuildContext? context;

  List<EngineType>? _engineTypes;

  int? _engineTypeId;

  int? _departurePlaceId;
  String? _departurePlaceType;

  int? _arrivalPlaceId;
  String? _arrivalPlaceType;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  int? _workers;

  get formKey => _formKey;

  get engineTypes => _engineTypes;

  get engineTypeController => _engineTypeId;

  get workers => _workers;

  String get createJourneyBusyObj => 'createJourneyBusyObj';

  void updateEngineType(int? value) {
    _engineTypeId = value;
  }

  Future<void> loadEngineTypes() async {
    runBusyFuture(_loadEngineTypes());
  }

  Future<void> _loadEngineTypes() async {
    _engineTypes = await _engineTypeService.loadEngineTypes(
        _applicationSettingsService.applicationSettings!.userLocaleLanguage,
        _applicationSettingsService.applicationSettings!.userLocaleCountry);
  }

  Future<void> updateJourneyRequest(journeyId) async {
    _journeyRequestService.updateJourneyRequest(
        journeyId,
        _departurePlaceId!,
        _departurePlaceType!,
        _arrivalPlaceId!,
        _arrivalPlaceType!,
        DateTime.parse(_selectedDate!.toIso8601String().split("T")[0] +
            " " +
            _selectedTime!.hour.toString().padLeft(2, '0') +
            ":" +
            _selectedTime!.minute.toString().padLeft(2, '0') +
            ":00"),
        _engineTypeId!,
        _workers ?? 0,
        descriptionValue!);
  }

  Future<void> createJourneyRequest() async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    runBusyFuture(
        _journeyRequestService
            .createJourneyRequest(
                _departurePlaceId!,
                _departurePlaceType!,
                _arrivalPlaceId!,
                _arrivalPlaceType!,
                DateTime.parse(_selectedDate!.toIso8601String().split("T")[0] +
                    " " +
                    _selectedTime!.hour.toString().padLeft(2, '0') +
                    ":" +
                    _selectedTime!.minute.toString().padLeft(2, '0') +
                    ":00"),
                _engineTypeId!,
                _workers ?? 0,
                descriptionValue!)
            .then((_) => _clearFormAndNavigateToJourneyRequests()),
        busyObject: createJourneyBusyObj);
  }

  @override
  void setFormStatus() {}

  void updateDeparturePlaceIdAndType(
      int departurePlaceId, String departurePlaceType) {
    _departurePlaceId = departurePlaceId;
    _departurePlaceType = departurePlaceType;
  }

  void updateArrivalPlaceIdAndType(
      int arrivalPlaceId, String arrivalPlaceType) {
    _arrivalPlaceId = arrivalPlaceId;
    _arrivalPlaceType = arrivalPlaceType;
  }

  saveWorkers(int? value) {}

  updateWorkers(String? value) {
    if (value != null) {
      _workers = int.parse(value);
    } else {
      _workers = 0;
    }
  }

  void updateSelectedDate(DateTime picked) {
    _selectedDate = picked;
  }

  void updateSelectedTime(TimeOfDay picked) {
    _selectedTime = picked;
  }

  @override
  void onFutureError(dynamic error, Object? key) {
    if (error is MobileValidationException) {
      _showValidateMobileBottomSheet();
    } else if (error is SocketException) {
      if (error.message == 'Connection failed') {
        _showErrorSnackbar(ErrorCode.CONNECTION_FAILED);
      } else {
        _showErrorSnackbar(ErrorCode.UNKNOWN);
      }
    } else {
      _showErrorSnackbar(ErrorCode.UNKNOWN);
    }
  }

  void _showErrorSnackbar(ErrorCode errorCode) {
    _snackbarService.showCustomSnackBar(
      variant: SnackbarType.error,
      message: _getErrorMessage(errorCode),
      //title: 'The message is the message',
      duration: Duration(seconds: 3),
      /* onTap: (_) {
          print('snackbar tapped');
        }, */
      //mainButtonTitle: 'Undo',
      //onMainButtonTapped: () => print('Undo the action!'),
    );
  }

  void _showSuccessSnackbar() {
    _snackbarService.showCustomSnackBar(
      variant: SnackbarType.success,
      message: 'success!',
      //title: 'The message is the message',
      duration: Duration(seconds: 3),
      /* onTap: (_) {
          print('snackbar tapped');
        }, */
      //mainButtonTitle: 'Undo',
      //onMainButtonTapped: () => print('Undo the action!'),
    );
  }

  String _getErrorMessage(ErrorCode errorCode) {
    switch (errorCode) {
      case ErrorCode.CONNECTION_FAILED:
        return AppLocalizations.of(context!)!.checkYourConnectionText;
      case ErrorCode.NOT_FOUND:
      case ErrorCode.UNAUTHORIZED:
      case ErrorCode.FORBIDDEN:
      case ErrorCode.SERVER_ERROR:
        return AppLocalizations.of(context!)!.somethingWentWrongText;
      case ErrorCode.BAD_REQUEST:
        return AppLocalizations.of(context!)!.authenticationBadCredentialsText;
      case ErrorCode.MOBILE_NOT_VALIDATED:
        return AppLocalizations.of(context!)!.validateMobileAlertText1;
      default:
        return AppLocalizations.of(context!)!.somethingWentWrongText;
    }
  }

  void setContext(BuildContext context) {
    this.context = context;
  }

  Future<void> _showValidateMobileBottomSheet() async {
    var confirmationResponse = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.FLOATING_BOX,
      title: AppLocalizations.of(context!)!.validateMobileAlertTitle,
      description: AppLocalizations.of(context!)!.validateMobileAlertText1 +
          AppLocalizations.of(context!)!.validateMobileAlertText2,
      mainButtonTitle: MaterialLocalizations.of(context!).cancelButtonLabel,
      secondaryButtonTitle: MaterialLocalizations.of(context!).okButtonLabel,
    );
    if (confirmationResponse != null) {
      //the bottom sheet was not dismissed
      if (confirmationResponse.confirmed) {
        _navigationService.navigateTo(Routes.mobileNumberCheckView);
      }
    }
  }

  _clearFormAndNavigateToJourneyRequests() {}
}
