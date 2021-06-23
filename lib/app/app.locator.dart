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
import '../api/user_locale_api.dart';
import '../services/authentication_service.dart';
import '../services/country_service.dart';
import '../services/environment_service.dart';
import '../services/local_storage_service.dart';
import '../services/user_locale_service.dart';
import '../utils/location_helper.dart';

final locator = StackedLocator.instance;

Future setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  final localStorageService = await LocalStorageService.getInstance();
  locator.registerSingleton(localStorageService);

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
}
