import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/exceptions/api_error_code.dart';
import 'package:fretto/exceptions/authentication_api_exception.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/models/gender.dart';
import 'package:fretto/services/application_settings_service.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/gender_service.dart';
import 'package:fretto/ui/views/signup/signup_view.form.dart';
import 'package:fretto/utils/validators.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupViewModel extends FormViewModel {
  final GenderService _genderService = locator<GenderService>();

  final NavigationService _navigationService = locator<NavigationService>();

  final ApplicationSettingsService _applicationSettingsService =
      locator<ApplicationSettingsService>();

  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final DateFormat _dateFormatter = DateFormat.yMd();
  bool _isInitialized = false;

  List<Gender>? _genders;

  String signupBusyObj = 'SignupBusyObj';
  String gendersBusyObj = 'gendersBusyObj';

  final _formKey = GlobalKey<FormState>();

  ErrorCode? _errorCode;

  int? _genderId;

  String _localeLanguageCode = 'en';
  String _localeCountryCode = 'US';

  bool? isTransporter;

  String? _icc;

  bool? _receiveNewsLetter;

  GlobalKey<FormState> get formKey => _formKey;

  get genderController => _genderId;

  get genders => _genders;

  get icc => _icc;

  get receiveNewsLetter => _receiveNewsLetter;

  Future<void> initialize() async {
    runBusyFuture(_initialize());
  }

  Future<void> _initialize() async {
    if (_applicationSettingsService.applicationSettings != null) {
      _localeLanguageCode =
          _applicationSettingsService.applicationSettings!.userLocaleLanguage;
      _localeCountryCode =
          _applicationSettingsService.applicationSettings!.userLocaleCountry;
    }
    _genders = await _genderService.loadGenders(
        _localeLanguageCode, _localeCountryCode);

    _genderId = _genders!.first.id;
    _icc = _applicationSettingsService.applicationSettings!.userCountryIcc;
    _receiveNewsLetter = false;

    _isInitialized = true;
  }

  void updateGender(int? value) {
    _genderId = value;
  }

  void updateReceiveNewsLetter(bool? value) {
    _receiveNewsLetter = value;
    notifyListeners();
  }

  void signup() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    runBusyFuture(
        _authenticationService
            .signup(
                emailValue!,
                _icc!,
                mobileNumberValue!,
                passwordValue!,
                isTransporter!,
                _genderId!,
                firstnameValue!,
                lastnameValue!,
                _dateFormatter.parse(dateOfBirthValue!),
                _receiveNewsLetter!)
            .then((_) {
          _navigationService.clearStackAndShow(Routes.homeView);
        }),
        busyObject: signupBusyObj);
  }

  void navigateToTermsOfService() {}

  void navigateToPrivacyPolicy() {}

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
      case ErrorCode.BAD_REQUEST:
        return AppLocalizations.of(context)!.somethingWentWrongText;

      default:
        return AppLocalizations.of(context)!.somethingWentWrongText;
    }
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  String? validatePasswordConfirmation(
      String? passwordConfirmation, BuildContext context) {
    String? validationMessage =
        Validators.passwordValidator(passwordConfirmation, context);
    if (validationMessage != null) return validationMessage;
    if (passwordValue != passwordConfirmation) {
      return AppLocalizations.of(context)!.signUpPasswordValidationMessage;
    }
    return null;
  }
}
