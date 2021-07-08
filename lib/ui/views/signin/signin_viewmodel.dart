import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/exceptions/authentication_api_exception.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/ui/shared/snackbar_type.dart';
import 'package:fretto/ui/views/signin/signin_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SigninViewModel extends FormViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final SnackbarService _snackbarService = locator<SnackbarService>();

  String signinBusyObj = 'SigninBusyObj';

  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  void signin() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    runBusyFuture(
        _authenticationService
            .signin(loginValue!, passwordValue!)
            .then((_) => _navigationService.clearStackAndShow(Routes.homeView)),
        busyObject: signinBusyObj);
  }

  void navigateToPasswordResetRequest() {}

  void navigateToAccountTypeChoice() {
    _navigationService.navigateTo(Routes.accountTypeChoiceView);
  }

  @override
  void setFormStatus() {}

  @override
  void onFutureError(dynamic error, Object? key) {
    if (error is AuthenticationApiException) {
      if (error.statusCode == 401) {
        _showErrorSnackbar(AppLocalizationDelegate
            .appLocalizations!.authenticationBadCredentialsText);
      } else {
        _showErrorSnackbar(
            AppLocalizationDelegate.appLocalizations!.somethingWentWrongText);
      }
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
