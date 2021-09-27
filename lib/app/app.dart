import 'package:fretto/api/authentication_api.dart';
import 'package:fretto/api/country_api.dart';
import 'package:fretto/api/device_token_api.dart';
import 'package:fretto/api/discussion_api.dart';
import 'package:fretto/api/engine_type_api.dart';
import 'package:fretto/api/gender_api.dart';
import 'package:fretto/api/geo_place_api.dart';
import 'package:fretto/api/journey_request_api.dart';
import 'package:fretto/api/local_storage_api.dart';
import 'package:fretto/api/messaging_api.dart';
import 'package:fretto/api/mobile_validation_api.dart';
import 'package:fretto/api/place_api.dart';
import 'package:fretto/api/user_locale_api.dart';
import 'package:fretto/api/user_profile_api.dart';
import 'package:fretto/services/application_settings_service.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/country_service.dart';
import 'package:fretto/services/discussion_service.dart';
import 'package:fretto/services/engine_type_service.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:fretto/services/gender_service.dart';
import 'package:fretto/services/geo_place_service.dart';
import 'package:fretto/services/journey_request_service.dart';
import 'package:fretto/services/messaging_service.dart';
import 'package:fretto/services/mobile_validation_service.dart';
import 'package:fretto/services/place_service.dart';
import 'package:fretto/services/push_notification_service.dart';
import 'package:fretto/services/user_locale_service.dart';
import 'package:fretto/services/user_profile_service.dart';
import 'package:fretto/ui/views/account_type_choice/account_type_choice_view.dart';
import 'package:fretto/ui/views/application_settings/application_settings_view.dart';
import 'package:fretto/ui/views/authentication_choice/authentication_choice_view.dart';
import 'package:fretto/ui/views/create_favorite_place/create_favorite_place_view.dart';
import 'package:fretto/ui/views/discussions/discussions_view.dart';
import 'package:fretto/ui/views/favorite_places/favorite_places_view.dart';
import 'package:fretto/ui/views/home/home_view.dart';
import 'package:fretto/ui/views/home/home_viewmodel.dart';
import 'package:fretto/ui/views/journey_creation/journey_creation_view.dart';
import 'package:fretto/ui/views/journey_creation/journey_creation_viewmodel.dart';
import 'package:fretto/ui/views/journey_details/journey_details_view.dart';
import 'package:fretto/ui/views/journey_proposals/journey_proposals_view.dart';
import 'package:fretto/ui/views/journey_requests/journey_requests_viewmodel.dart';
import 'package:fretto/ui/views/messaging/messaging_view.dart';
import 'package:fretto/ui/views/mobile_number_check/mobile_number_check_view.dart';
import 'package:fretto/ui/views/mobile_validation_sms_code/mobile_validation_sms_code_view.dart';
import 'package:fretto/ui/views/profile/profile_viewmodel.dart';
import 'package:fretto/ui/views/signin/signin_view.dart';
import 'package:fretto/ui/views/signup/signup_view.dart';
import 'package:fretto/ui/views/startup/startup_view.dart';
import 'package:fretto/utils/location_helper.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: ApplicationSettingsView),
    MaterialRoute(page: AuthenticationChoiceView),
    MaterialRoute(page: SigninView),
    MaterialRoute(page: AccountTypeChoiceView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: CreateFavoritePlaceView),
    MaterialRoute(page: FavoritePlacesView),
    MaterialRoute(page: MobileNumberCheckView),
    MaterialRoute(page: MobileValidationSMSCodeView),
    MaterialRoute(page: JourneyCreationView),
    MaterialRoute(page: JourneyDetailsView),
    MaterialRoute(page: JourneyProposalsView),
    MaterialRoute(page: DiscussionsView),
    MaterialRoute(page: MessagingView),
  ],
  dependencies: [
    Presolve(
        classType: LocalStorageApi, presolveUsing: LocalStorageApi.getInstance),
    Presolve(
        classType: EnvironmentService,
        presolveUsing: EnvironmentService.getInstance),
    Singleton(classType: NavigationService),
    Singleton(classType: SnackbarService),
    Singleton(classType: BottomSheetService),
    LazySingleton(classType: ApplicationSettingsService),
    LazySingleton(classType: AuthenticationApi),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: EngineTypeApi),
    LazySingleton(classType: EngineTypeService),
    LazySingleton(classType: JourneyRequestApi),
    LazySingleton(classType: JourneyRequestService),
    LazySingleton(classType: JourneyCreationViewModel),
    LazySingleton(classType: JourneyRequestsViewModel),
    LazySingleton(classType: ProfileViewModel),
    LazySingleton(classType: HomeViewModel),
    LazySingleton(classType: CountryApi),
    LazySingleton(classType: CountryService),
    LazySingleton(classType: UserLocaleApi),
    LazySingleton(classType: UserLocaleService),
    LazySingleton(classType: LocationHelper),
    LazySingleton(classType: GenderApi),
    LazySingleton(classType: GenderService),
    LazySingleton(classType: PlaceApi),
    LazySingleton(classType: PlaceService),
    LazySingleton(classType: UserProfileApi),
    LazySingleton(classType: UserProfileService),
    LazySingleton(classType: MobileValidationApi),
    LazySingleton(classType: MobileValidationService),
    LazySingleton(classType: GeoPlaceApi),
    LazySingleton(classType: GeoPlaceService),
    LazySingleton(classType: DiscussionApi),
    LazySingleton(classType: DiscussionService),
    LazySingleton(classType: PushNotificationService),
    LazySingleton(classType: MessagingApi),
    LazySingleton(classType: MessagingService),
    LazySingleton(classType: DeviceTokenApi),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
