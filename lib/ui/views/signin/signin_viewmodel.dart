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

  ApiErrorCode? _errorCode;

  GlobalKey<FormState> get formKey => _formKey;

  void signin() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    runBusyFuture(_authenticationService.signin(loginValue!, passwordValue!),
        busyObject: signinBusyObj);

    _navigationService.replaceWith(Routes.homeView);
  }

  void navigateToPasswordResetRequest() {}

  void navigateToAccountTypeChoice() {}

  @override
  void setFormStatus() {}

  @override
  void onFutureError(dynamic error, Object? key) {
    if (error is AuthenticationApiException) {
      if (error.statusCode == 400) {
        _errorCode = ApiErrorCode.BAD_REQUEST;
      } else if (error.statusCode == 404) {
        _errorCode = ApiErrorCode.NOT_FOUND;
      } else if (error.statusCode == 401) {
        _errorCode = ApiErrorCode.UNAUTHORIZED;
      } else if (error.statusCode == 403) {
        _errorCode = ApiErrorCode.FORBIDDEN;
      } else if (error.statusCode == 500) {
        _errorCode = ApiErrorCode.SERVER_ERROR;
      } else {
        _errorCode = ApiErrorCode.UNKNOWN;
      }
    } else if (error is SocketException) {
      if (error.message == 'Connection failed') {
        _errorCode = ApiErrorCode.CONNECTION_FAILED;
      } else {
        _errorCode = ApiErrorCode.UNKNOWN;
      }
    } else {
      _errorCode = ApiErrorCode.UNKNOWN;
    }
  }

  String getErrorMessage(BuildContext context) {
    switch (_errorCode) {
      case ApiErrorCode.CONNECTION_FAILED:
        return AppLocalizations.of(context)!.checkYourConnectionText;
      case ApiErrorCode.NOT_FOUND:
      case ApiErrorCode.UNAUTHORIZED:
      case ApiErrorCode.FORBIDDEN:
      case ApiErrorCode.SERVER_ERROR:
        return AppLocalizations.of(context)!.somethingWentWrongText;
      case ApiErrorCode.BAD_REQUEST:
        return AppLocalizations.of(context)!.authenticationBadCredentialsText;
      default:
        return AppLocalizations.of(context)!.somethingWentWrongText;
    }
  }
}
