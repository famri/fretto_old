import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/exceptions/api_error_code.dart';
import 'package:fretto/exceptions/authentication_api_exception.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/ui/views/signin/signin_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SigninViewModel extends FormViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  String signinBusyObj = 'SigninBusyObj';

  final _formKey = GlobalKey<FormState>();

  ErrorCode? _errorCode;

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
      if (error.statusCode == 400) {
        _errorCode = ErrorCode.BAD_REQUEST;
      } else if (error.statusCode == 404) {
        _errorCode = ErrorCode.NOT_FOUND;
      } else if (error.statusCode == 401) {
        _errorCode = ErrorCode.UNAUTHORIZED;
      } else if (error.statusCode == 403) {
        _errorCode = ErrorCode.FORBIDDEN;
      } else if (error.statusCode == 500) {
        _errorCode = ErrorCode.SERVER_ERROR;
      } else {
        _errorCode = ErrorCode.UNKNOWN;
      }
    } else if (error is SocketException) {
      if (error.message == 'Connection failed') {
        _errorCode = ErrorCode.CONNECTION_FAILED;
      } else {
        _errorCode = ErrorCode.UNKNOWN;
      }
    } else {
      _errorCode = ErrorCode.UNKNOWN;
    }
  }

  String getErrorMessage(BuildContext context) {
    switch (_errorCode) {
      case ErrorCode.CONNECTION_FAILED:
        return AppLocalizations.of(context)!.checkYourConnectionText;
      case ErrorCode.NOT_FOUND:
      case ErrorCode.UNAUTHORIZED:
      case ErrorCode.FORBIDDEN:
      case ErrorCode.SERVER_ERROR:
        return AppLocalizations.of(context)!.somethingWentWrongText;
      case ErrorCode.BAD_REQUEST:
        return AppLocalizations.of(context)!.authenticationBadCredentialsText;
      default:
        return AppLocalizations.of(context)!.somethingWentWrongText;
    }
  }
}
