import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/exceptions/mobile_validation_api_exception.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/services/mobile_validation_service.dart';
import 'package:fretto/ui/shared/snackbar_type.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'mobile_validation_sms_code_view.form.dart';

class MobileValidationSMSCodeViewModel extends FormViewModel {
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final MobileValidationService _mobileValidationService = locator<MobileValidationService>();
  GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  GlobalKey<FormState>? get formKey => _formKey;

  Future<void> validateSmsCode() async {
    bool isValid = _formKey!.currentState!.validate();
    if (isValid) {
      //send sms code to server for checking
      bool isGoodCode =
          await runBusyFuture<bool>(_mobileValidationService.validateMobileValidationCode(smsCodeValue!));
      if (isGoodCode) {
        _showSuccessSnackbar('Le code SMS est validé avec succès.');
        _formKey = null;
        Future.delayed(
            Duration(seconds: 3),
            () => _navigationService
                .popUntil(ModalRoute.withName(Routes.homeView)));
      } else {
        _showErrorSnackbar('Le code SMS est incorrect.');
      }
    }
  }

  void resendSmsCode(String icc, String mobileNumber) {}
  void _showErrorSnackbar(String message) {
    _snackbarService.showCustomSnackBar(
      variant: SnackbarType.error,
      message: message,
      duration: Duration(seconds: 3),
    );
  }

  void _showSuccessSnackbar(String message) {
    _snackbarService.showCustomSnackBar(
      variant: SnackbarType.error,
      message: message,
      duration: Duration(seconds: 3),
    );
  }
 @override
  void onFutureError(dynamic error, Object? key) {
    if (error is MobileValidationApiException ) {
      _showErrorSnackbar(
          AppLocalizationDelegate.appLocalizations!.somethingWentWrongText);
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
  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
