// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../api/authentication_api.dart';
import '../api/country_api.dart';
import '../api/gender_api.dart';
import '../api/local_storage_api.dart';
import '../api/user_locale_api.dart';
import '../services/application_settings_service.dart';
import '../services/authentication_service.dart';
import '../services/country_service.dart';
import '../services/environment_service.dart';
import '../services/gender_service.dart';
import '../services/user_locale_service.dart';
import '../utils/location_helper.dart';

final locator = StackedLocator.instance;

Future setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  final localStorageApi = await LocalStorageApi.getInstance();
  locator.registerSingleton(localStorageApi);

  final environmentService = await EnvironmentService.getInstance();
  locator.registerSingleton(environmentService);

  locator.registerSingleton(NavigationService());
  locator.registerLazySingleton(() => CountryApi());
  locator.registerLazySingleton(() => CountryService());
  locator.registerLazySingleton(() => UserLocaleApi());
  locator.registerLazySingleton(() => UserLocaleService());
  locator.registerLazySingleton(() => LocationHelper());
  locator.registerLazySingleton(() => AuthenticationApi());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => ApplicationSettingsService());
  locator.registerLazySingleton(() => GenderApi());
  locator.registerLazySingleton(() => GenderService());
}
