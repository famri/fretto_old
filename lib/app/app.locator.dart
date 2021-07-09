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
import '../api/engine_type_api.dart';
import '../api/gender_api.dart';
import '../api/geo_place_api.dart';
import '../api/journey_request_api.dart';
import '../api/local_storage_api.dart';
import '../api/mobile_validation_api.dart';
import '../api/place_api.dart';
import '../api/user_locale_api.dart';
import '../api/user_profile_api.dart';
import '../services/application_settings_service.dart';
import '../services/authentication_service.dart';
import '../services/country_service.dart';
import '../services/engine_type_service.dart';
import '../services/environment_service.dart';
import '../services/gender_service.dart';
import '../services/geo_place_service.dart';
import '../services/journey_request_service.dart';
import '../services/mobile_validation_service.dart';
import '../services/place_service.dart';
import '../services/user_locale_service.dart';
import '../services/user_profile_service.dart';
import '../ui/views/discussions/discussions_viemodel.dart';
import '../ui/views/journey_creation/journey_creation_viewmodel.dart';
import '../ui/views/journey_requests/journey_requests_viewmodel.dart';
import '../ui/views/profile/profile_viewmodel.dart';
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
  locator.registerSingleton(SnackbarService());
  locator.registerSingleton(BottomSheetService());
  locator.registerLazySingleton(() => ApplicationSettingsService());
  locator.registerLazySingleton(() => AuthenticationApi());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => EngineTypeApi());
  locator.registerLazySingleton(() => EngineTypeService());
  locator.registerLazySingleton(() => JourneyRequestApi());
  locator.registerLazySingleton(() => JourneyRequestService());
  locator.registerLazySingleton(() => JourneyCreationViewModel());
  locator.registerLazySingleton(() => JourneyRequestsViewModel());
  locator.registerLazySingleton(() => DiscussionsViewModel());
  locator.registerLazySingleton(() => ProfileViewModel());
  locator.registerLazySingleton(() => CountryApi());
  locator.registerLazySingleton(() => CountryService());
  locator.registerLazySingleton(() => UserLocaleApi());
  locator.registerLazySingleton(() => UserLocaleService());
  locator.registerLazySingleton(() => LocationHelper());
  locator.registerLazySingleton(() => GenderApi());
  locator.registerLazySingleton(() => GenderService());
  locator.registerLazySingleton(() => PlaceApi());
  locator.registerLazySingleton(() => PlaceService());
  locator.registerLazySingleton(() => UserProfileApi());
  locator.registerLazySingleton(() => UserProfileService());
  locator.registerLazySingleton(() => MobileValidationApi());
  locator.registerLazySingleton(() => MobileValidationService());
  locator.registerLazySingleton(() => GeoPlaceApi());
  locator.registerLazySingleton(() => GeoPlaceService());
}
