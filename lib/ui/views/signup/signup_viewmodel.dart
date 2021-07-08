import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/exceptions/authentication_api_exception.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/models/gender.dart';
import 'package:fretto/services/application_settings_service.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/gender_service.dart';
import 'package:fretto/ui/shared/snackbar_type.dart';
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

  final SnackbarService _snackbarService = locator<SnackbarService>();

  final DateFormat _dateFormatter = DateFormat.yMd();
  bool _isInitialized = false;

  List<Gender>? _genders;

  String signupBusyObj = 'SignupBusyObj';
  String gendersBusyObj = 'gendersBusyObj';

  final _formKey = GlobalKey<FormState>();

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

  String? validatePasswordConfirmation(
      String? passwordConfirmation) {
    String? validationMessage =
        Validators.passwordValidator(passwordConfirmation);
    if (validationMessage != null) return validationMessage;
    if (passwordValue != passwordConfirmation) {
      return AppLocalizationDelegate.appLocalizations!.signUpPasswordValidationMessage;
    }
    return null;
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
