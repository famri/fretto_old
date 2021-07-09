import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/exceptions/mobile_validation_exception.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/models/engine_type.dart';
import 'package:fretto/models/geo_place_dto.dart';
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
  GlobalKey<FormState>? _formKey = GlobalKey<FormState>();

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
    bool isValid = _formKey!.currentState!.validate();
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

  void setContext(BuildContext context) {
    this.context = context;
  }

  Future<void> _showValidateMobileBottomSheet() async {
    var confirmationResponse = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.FLOATING_BOX,
      title: AppLocalizationDelegate.appLocalizations!.validateMobileAlertTitle,
      description: AppLocalizationDelegate
              .appLocalizations!.validateMobileAlertText1 +
          AppLocalizationDelegate.appLocalizations!.validateMobileAlertText2,
      mainButtonTitle: 'CANCEL',
      secondaryButtonTitle: 'OK',
    );
    if (confirmationResponse != null) {
      //the bottom sheet was not dismissed
      if (confirmationResponse.confirmed) {
        _navigationService.navigateTo(Routes.mobileNumberCheckView);
      }
    }
  }

  _clearFormAndNavigateToJourneyRequests() {
    _clearForm();
    _showSuccessSnackbar(
        AppLocalizationDelegate.appLocalizations!.createJourneyAppBarTitle);

    Future.delayed(
        Duration(seconds: 3),
        () => _navigationService.navigateTo(Routes.homeView,
            arguments: HomeViewArguments(viewIndex: 1)));
  }

  void _clearForm() {
    formValueMap[ArrivalValueKey] = null;
    formValueMap[DepartureValueKey] = null;

    formValueMap[DateValueKey] = null;
    formValueMap[TimeValueKey] = null;
    formValueMap[DescriptionValueKey] = null;
    _engineTypeId = null;
    _departurePlaceId = null;
    _departurePlaceType = null;
    _arrivalPlaceId = null;
    _arrivalPlaceType = null;
    _selectedDate = null;
    _selectedTime = null;
    _workers = null;
    _formKey = null;
    notifyListeners();
  }

  Future<GeoPlaceDto?> navigateToFavoriteGeoPlaces() async {
    GeoPlaceDto? geoPlace =
        await _navigationService.navigateTo(Routes.favoritePlacesView);

    return geoPlace;
  }
}
