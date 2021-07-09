import 'dart:io';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/exceptions/geo_place_api_exception.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/models/geo_place_dto.dart';
import 'package:fretto/services/application_settings_service.dart';
import 'package:fretto/services/geo_place_service.dart';
import 'package:fretto/ui/shared/snackbar_type.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FavoritePlacesViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final GeoPlaceService _geoPlaceService = locator<GeoPlaceService>();
  final ApplicationSettingsService _applicationSettingsService =
      locator<ApplicationSettingsService>();

  final SnackbarService _snackbarService = locator<SnackbarService>();

  List<GeoPlaceDto>? _userFavoritePlaces;
  List<GeoPlaceDto>? get userFavoritePlaces => _userFavoritePlaces;

  Future<void> navigateToCreateFavoritePlace() async {
    GeoPlaceDto createdGeoPlace =
        await _navigationService.navigateTo(Routes.createFavoritePlaceView);
    if (_userFavoritePlaces != null) {
      _userFavoritePlaces = [createdGeoPlace, ..._userFavoritePlaces!];
    } else {
      _userFavoritePlaces = [createdGeoPlace];
    }
    notifyListeners();
  }

  void loadUserFavoritePlaces() {
    runBusyFuture(_loadFavoritePlaces());
  }

  Future<void> _loadFavoritePlaces() async {
    _userFavoritePlaces = await _geoPlaceService.loadFavoriteGeoPlaces(
        _applicationSettingsService.applicationSettings!.userLocaleLanguage,
        _applicationSettingsService.applicationSettings!.userLocaleCountry);
  }

  void returnGeoPlace(int index) {
    _navigationService.back(result: _userFavoritePlaces![index]);
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
}
