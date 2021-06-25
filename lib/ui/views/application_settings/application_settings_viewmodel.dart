import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/application_settings_exception.dart';
import 'package:fretto/models/application_settings.dart';
import 'package:fretto/models/country.dart';
import 'package:fretto/models/user_locale.dart';
import 'package:fretto/services/country_service.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:fretto/services/local_storage_service.dart';
import 'package:fretto/services/user_locale_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../main.dart';
import 'package:flutter/material.dart';

class ApplicationSettingsViewModel extends BaseViewModel {
  final EnvironmentService environmentService = locator<EnvironmentService>();
  final LocalStorageService localStorageService =
      locator<LocalStorageService>();
  final CountryService _countryService = locator<CountryService>();
  final UserLocaleService _userLocaleService = locator<UserLocaleService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool _isInitialized = false;

  int? _userCountryId;
  int? _userLocaleId;
  int? _userTimezoneId;

  List<Country>? _countries;
  List<UserLocale>? _userLocales;

  String _userLocaleLanguageCode = 'en';
  String _userLocaleCountryCode = 'US';

  get appName => environmentService.getValue(AppName);

  get appDomain => environmentService.getValue(AppDomain);

  get countries => _countries;
  get userLocales => _userLocales;

  get countryController => _userCountryId;

  get localeContoller => _userLocaleId;

  get timeZoneController => _userTimezoneId;

  Future<void> saveSettings(BuildContext context) async {
    await runBusyFuture(_saveApplicationSettings(context));
    _checkLocaleChangeForRestart(context);
  }

  void updateCountry(int? value) {
    _userLocaleId = value;
  }

  void updateLocaleController(int? value) {
    _userLocaleId = value;
  }

  void updateTimeZoneController(int? value) {
    _userTimezoneId = value;
  }

  Future<void> loadCountriesAndUserLocales() async {
    setBusy(true);
    if (localStorageService.applicationSettings != null) {
      _userLocaleLanguageCode =
          localStorageService.applicationSettings!.userLocaleLanguage;
      _userLocaleCountryCode =
          localStorageService.applicationSettings!.userLocaleCountry;
    }

    _countries = await _countryService.loadCountries(
        _userLocaleLanguageCode, _userLocaleCountryCode);

    _userLocales = await _userLocaleService.loadUserLocales();

    if (localStorageService.applicationSettings != null) {
      _userCountryId = localStorageService.applicationSettings!.userCountryId;
      _userLocaleId = localStorageService.applicationSettings!.userLocaleId;
      _userTimezoneId = localStorageService.applicationSettings!.userTimeZoneId;
    } else {
      _userCountryId = _countries!.first.id;
      _userLocaleId = _userLocales!.first.id;
      _userTimezoneId = _countries!.first.timeZones.first.id;
    }
    _isInitialized = true;
    setBusy(false);
  }

  Future<void> _saveApplicationSettings(BuildContext context) async {
    if (_isInitialized) {
      localStorageService.applicationSettings = ApplicationSettings(
          userCountryId: _userCountryId!,
          userLocaleId: _userLocaleId!,
          userTimeZoneId: _userTimezoneId!,
          timeZoneName: _countries!
              .firstWhere((element) => element.id == _userCountryId)
              .timeZones
              .firstWhere((element) => element.id == _userTimezoneId)
              .name,
          userLocaleCountry: _userLocales!
              .firstWhere((element) => element.id == _userLocaleId)
              .countryCode,
          userLocaleLanguage: _userLocales!
              .firstWhere((element) => element.id == _userLocaleId)
              .languageCode,
          userCountryIcc: _countries!
              .firstWhere((element) => element.id == _userCountryId)
              .icc
              .value);
      _checkLocaleChangeForRestart(context);
    } else {
      throw ApplicationSettingsException(message: 'Cannot save null settings.');
    }
  }

  void _checkLocaleChangeForRestart(BuildContext context) {
    if (_userLocales!
                .firstWhere((element) => element.id == _userLocaleId)
                .countryCode !=
            'US' ||
        _userLocales!
                .firstWhere((element) => element.id == _userLocaleId)
                .languageCode !=
            'en') {
      Fretto.restartApp(context);
    }
    _navigationService.replaceWith(Routes.startupView);
  }
}
