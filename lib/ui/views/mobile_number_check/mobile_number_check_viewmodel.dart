import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/exceptions/mobile_validation_api_exception.dart';
import 'package:fretto/exceptions/user_profile_api_exception.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/models/user_profile_info.dart';
import 'package:fretto/services/application_settings_service.dart';
import 'package:fretto/services/country_service.dart';
import 'package:fretto/services/mobile_validation_service.dart';
import 'package:fretto/services/user_profile_service.dart';
import 'package:fretto/ui/shared/snackbar_type.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'mobile_number_check_view.form.dart';

class MobileNumberCheckViewModel extends FormViewModel {
  final UserProfileService _userProfileService = locator<UserProfileService>();

  final ApplicationSettingsService _applicationSettingsService =
      locator<ApplicationSettingsService>();
  final CountryService _countryService = locator<CountryService>();

  final MobileValidationService _smsService =
      locator<MobileValidationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();
  GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  UserProfileInfo? _initialUserProfileInfo;

  String? _mobileNumber;
  int? _iccId;
  Map<int, IccInfoDto>? _internationalCallingCodes;

  GlobalKey<FormState>? get formKey => _formKey;

  int? get iccId => _iccId;

  String? get mobileNumber => _mobileNumber;

  Map<int, IccInfoDto>? get internationalCallingCodes =>
      _internationalCallingCodes;

  Future<void> checkMobile() async {
    bool isValid = _formKey!.currentState!.validate();
    if (!isValid) return;
    runBusyFuture(_checkMobile());
  }

  Future<void> _checkMobile() async {
    if (_initialUserProfileInfo!.mobile.icc.id != _iccId ||
        _initialUserProfileInfo!.mobile.value != mobileNumberValue) {
      await _userProfileService.updateMobileInfo(_iccId!, mobileNumberValue!);
    }

    String icc = _internationalCallingCodes![_iccId]!.value;
    await _smsService.sendMobileValidationCode(
        icc,
        mobileNumberValue!,
        _applicationSettingsService.applicationSettings!.userLocaleLanguage,
        _applicationSettingsService.applicationSettings!.userLocaleCountry);

    _formKey = null;
    _navigationService.navigateTo(Routes.mobileValidationSMSCodeView,
        arguments: MobileValidationSMSCodeViewArguments(
            icc: icc, mobileNumber: mobileNumberValue!));
  }

  @override
  void onFutureError(dynamic error, Object? key) {
    if (error is MobileValidationApiException ||
        error is UserProfileApiException) {
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

  void _showErrorSnackbar(String message) {
    _snackbarService.showCustomSnackBar(
      variant: SnackbarType.error,
      message: message,
      duration: Duration(seconds: 3),
    );
  }

  Future<void> init() async {
    // load internation calling codes
    _internationalCallingCodes =
        await _countryService.loadInternationalCallingCodes(
            _applicationSettingsService.applicationSettings!.userLocaleLanguage,
            _applicationSettingsService.applicationSettings!.userLocaleCountry);

    //load user mobile info
    _initialUserProfileInfo = await _userProfileService.loadUserProfileInfo(
        _applicationSettingsService.applicationSettings!.userLocaleLanguage,
        _applicationSettingsService.applicationSettings!.userLocaleCountry);

    _mobileNumber = _initialUserProfileInfo!.mobile.value;

    _iccId = _initialUserProfileInfo!.mobile.icc.id;
  }

  void updateIccId(int? value) {
    _iccId = value;
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
