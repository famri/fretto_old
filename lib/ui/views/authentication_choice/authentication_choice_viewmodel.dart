import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticationChoiceViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  void navigateToSignIn() {
    _navigationService.navigateTo(Routes.signinView);
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(Routes.signupView);
  }
}
