import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AccountTypeChoiceViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  bool? _isTransporter;
  get isTransporter => _isTransporter;

  void navigateToSignup(BuildContext context) {
    if (_isTransporter == null) {
      setError(AppLocalizations.of(context)!.chooseUserTypeErrorText);
    } else {
      _navigationService.navigateTo(Routes.signupView,
          arguments: SignupViewArguments(isTransporter: _isTransporter!));
    }
  }

  void updateIsTransporter(bool value) {
    this._isTransporter = value;
    notifyListeners();
  }
}
