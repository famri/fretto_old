import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/local_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final AuthenticationService _authenticatonService =
      locator<AuthenticationService>();
  Future<void> runStartupLogic() async {
    if (_localStorageService.applicationSettings == null) {
      _navigationService.replaceWith(Routes.applicationSettingsView);
    } else if (await _authenticatonService.tryAutoLogin()) {
      _navigationService.replaceWith(Routes.homeView);
    } else {
      _navigationService.replaceWith(Routes.authenticationChoiceView);
    }
  }
}
