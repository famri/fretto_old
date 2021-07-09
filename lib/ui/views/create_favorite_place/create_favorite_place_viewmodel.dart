import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/exceptions/geo_place_api_exception.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/models/place_location.dart';
import 'package:fretto/services/application_settings_service.dart';
import 'package:fretto/services/geo_place_service.dart';
import 'package:fretto/ui/shared/snackbar_type.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'create_favorite_place_view.form.dart';

class CreateFavoritePlaceViewModel extends FormViewModel {
  final GeoPlaceService _geoPlaceService = locator<GeoPlaceService>();
  final ApplicationSettingsService _applicationSettingsService =
      locator<ApplicationSettingsService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final String placeSelection = 'placeSelection';

  PlaceLocation? _placeLocation;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  Future<void> runBusySaveFavoritePlace() async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    if (_placeLocation == null) {
      setErrorForObject(
          placeSelection,
          AppLocalizationDelegate
              .appLocalizations!.addFavoriteLocationMissingPlaceLocation);
      notifyListeners();
      return;
    }

    runBusyFuture(_geoPlaceService.saveFavoriteGeoPlace(
            placeTitleValue!,
            _placeLocation!,
            _applicationSettingsService.applicationSettings!.userLocaleLanguage,
            _applicationSettingsService.applicationSettings!.userLocaleCountry))
        .then((createdGeoPlace) =>
            _navigationService.back(result: createdGeoPlace));
  }

  void selectPlace(double latitude, double longitude) {
    _placeLocation = PlaceLocation(latitude: latitude, longitude: longitude);
  }

  @override
  void onFutureError(dynamic error, Object? key) {
    if (error is GeoPlaceApiException) {
      _showErrorSnackbar(
          AppLocalizationDelegate.appLocalizations!.somethingWentWrongText);
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

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
