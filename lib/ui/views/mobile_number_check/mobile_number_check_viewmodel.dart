import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/exceptions/api_error_code.dart';
import 'package:fretto/exceptions/sms_api_exception.dart';
import 'package:fretto/exceptions/user_profile_api_exception.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/models/user_profile_info.dart';
import 'package:fretto/services/application_settings_service.dart';
import 'package:fretto/services/country_service.dart';
import 'package:fretto/services/sms_service.dart';
import 'package:fretto/services/user_profile_service.dart';
import 'package:fretto/ui/shared/snackbar_type.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MobileNumberCheckViewModel
    extends FutureViewModel<MobileNumberCheckViewModelData> {
  final UserProfileService _userProfileService = locator<UserProfileService>();

  final ApplicationSettingsService _applicationSettingsService =
      locator<ApplicationSettingsService>();
  final CountryService _countryService = locator<CountryService>();

  final SMSService _smsService = locator<SMSService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController mobileNumberController = TextEditingController();
  String? _mobileNumber;
  int? _iccId;

  get formKey => _formKey;

  get iccId => _iccId;

  Future<void> checkMobile() async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    runBusyFuture(_checkMobile());
  }

  Future<void> _checkMobile() async {
    await _userProfileService.updateMobileInfo(_iccId!, _mobileNumber!);
    await _smsService.sendMobileValidationCode(
        data!.internationalCallingCodes![_iccId]!.value,
        _mobileNumber!,
        _applicationSettingsService.applicationSettings!.userLocaleLanguage,
        _applicationSettingsService.applicationSettings!.userLocaleCountry);
    _navigationService.navigateTo('Routes.mobileNumberValidationView');
  }

  @override
  void onFutureError(dynamic error, Object? key) {
    if (error is SMSApiException || error is UserProfileApiException) {
      _showErrorSnackbar(ErrorCode.SERVER_ERROR);
    } else if (error is SocketException) {
      if (error.message == 'Connection failed') {
        _showErrorSnackbar(ErrorCode.CONNECTION_FAILED);
      } else {
        _showErrorSnackbar(ErrorCode.UNKNOWN);
      }
    } else {
      _showErrorSnackbar(ErrorCode.UNKNOWN);
    }
  }

  void _showErrorSnackbar(ErrorCode errorCode) {
    _snackbarService.showCustomSnackBar(
      variant: SnackbarType.error,
      message: AppLocalizationDelegate.instance!.checkYourConnectionText,
      //title: 'The message is the message',
      duration: Duration(seconds: 3),
      /* onTap: (_) {
          print('snackbar tapped');
        }, */
      //mainButtonTitle: 'Undo',
      //onMainButtonTapped: () => print('Undo the action!'),
    );
  }

  Future<MobileNumberCheckViewModelData> _initialize() async {
    // load internation calling codes
    Map<int, IccInfoDto>? internationalCallingCodes =
        await _countryService.loadInternationalCallingCodes(
            _applicationSettingsService.applicationSettings!.userLocaleLanguage,
            _applicationSettingsService.applicationSettings!.userLocaleCountry);

    //load user mobile info
    UserProfileInfo userProfileInfo =
        await _userProfileService.loadUserProfileInfo(
            _applicationSettingsService.applicationSettings!.userLocaleLanguage,
            _applicationSettingsService.applicationSettings!.userLocaleCountry);

    _mobileNumber = userProfileInfo.mobile.value;

    _iccId = userProfileInfo.mobile.icc.id;
    mobileNumberController.text = _mobileNumber!;
    return MobileNumberCheckViewModelData(
        internationalCallingCodes, userProfileInfo.mobile);
  }

  void updateIccId(int? value) {
    _iccId = value;
  }

  @override
  Future<MobileNumberCheckViewModelData> futureToRun() => _initialize();
}

class MobileNumberCheckViewModelData {
  final Map<int, IccInfoDto>? internationalCallingCodes;
  final MobileInfo mobileInfo;

  MobileNumberCheckViewModelData(
      this.internationalCallingCodes, this.mobileInfo);
}
