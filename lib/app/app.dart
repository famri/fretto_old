import 'package:fretto/api/authentication_api.dart';
import 'package:fretto/api/country_api.dart';
import 'package:fretto/api/user_locale_api.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/country_service.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:fretto/services/local_storage_service.dart';
import 'package:fretto/services/user_locale_service.dart';
import 'package:fretto/ui/views/account_type_choice/account_type_choice_view.dart';
import 'package:fretto/ui/views/application_settings/application_settings_view.dart';
import 'package:fretto/ui/views/authentication_choice/authentication_choice_view.dart';
import 'package:fretto/ui/views/home/home_view.dart';
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
  ],
  dependencies: [
    Presolve(
        classType: LocalStorageService,
        presolveUsing: LocalStorageService.getInstance),
    Presolve(
        classType: EnvironmentService,
        presolveUsing: EnvironmentService.getInstance),
    Singleton(classType: NavigationService),
    LazySingleton(classType: CountryApi),
    LazySingleton(classType: CountryService),
    LazySingleton(classType: UserLocaleApi),
    LazySingleton(classType: UserLocaleService),
    LazySingleton(classType: LocationHelper),
    LazySingleton(classType: AuthenticationApi),
    LazySingleton(classType: AuthenticationService),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
