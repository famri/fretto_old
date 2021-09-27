import 'dart:async';
import 'dart:convert';

import 'package:fretto/api/authentication_api.dart';
import 'package:fretto/api/local_storage_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/authentication_exception.dart';
import 'package:fretto/models/bearer_token_info.dart';
import 'package:fretto/models/user_auth_data.dart';
import 'package:fretto/models/user_info.dart';
import 'package:fretto/services/application_settings_service.dart';
import 'package:fretto/utils/validators.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticationService {
  Logger log = getLogger('AuthenticationService');
  final AuthenticationApi _authenticationApi = locator<AuthenticationApi>();
  final LocalStorageApi _localStorageApi = locator<LocalStorageApi>();
  final ApplicationSettingsService _applicationSettingsService =
      locator<ApplicationSettingsService>();
  final NavigationService _navigationService = locator<NavigationService>();

  UserAuthData? _userAuthData;
  Timer? _authTimer;

  bool get isClient =>
      _userAuthData != null &&
      _userAuthData!.authorities != null &&
      _userAuthData!.authorities!.contains('ROLE_CLIENT');

  bool get isAuthenticated =>
      _userAuthData != null &&
      _userAuthData!.token != null &&
      _userAuthData!.expiryDate!.isAfter(DateTime.now());

  String? get token => _userAuthData == null ? null : _userAuthData!.token;

  Future<bool> signin(String username, String password) async {
    // if username is mobile number then try to add international calling code
    if (Validators.isMobileNumber(username)) {
      if (_applicationSettingsService.applicationSettings != null) {
        String countryIcc =
            _applicationSettingsService.applicationSettings!.userCountryIcc;
        username = countryIcc + '_' + username;
      }
    }
    BearerTokenInfo bearerTokenInfo =
        await _authenticationApi.signin(username, password);
    UserInfo userInfo =
        await _authenticationApi.checkAccessToken(bearerTokenInfo.token);
    _userAuthData = UserAuthData(
        token: bearerTokenInfo.token,
        refreshToken: bearerTokenInfo.refreshToken,
        expiryDate: bearerTokenInfo.expiryDate,
        username: userInfo.username,
        authorities: userInfo.authorities);
    // Save new userAuthData
    bool isSuccessfullyAuthenticated =
        await _updateStoredUserAuthData(_userAuthData);

    return isSuccessfullyAuthenticated;
  }

  Future<bool> signup(
      String email,
      String icc,
      String mobileNumber,
      String userPassword,
      bool isTransporter,
      int gender,
      String firstname,
      String lastname,
      DateTime dateOfBirth,
      bool receiveNewsletter) async {
    BearerTokenInfo bearerTokenInfo = await _authenticationApi.signup(
        email,
        icc,
        mobileNumber,
        userPassword,
        isTransporter,
        gender,
        firstname,
        lastname,
        dateOfBirth,
        receiveNewsletter);

    UserInfo userInfo =
        await _authenticationApi.checkAccessToken(bearerTokenInfo.token);
    _userAuthData = UserAuthData(
        token: bearerTokenInfo.token,
        refreshToken: bearerTokenInfo.refreshToken,
        expiryDate: bearerTokenInfo.expiryDate,
        username: userInfo.username,
        authorities: userInfo.authorities);
    // Save new userAuthData
    bool isSuccessfullyAuthenticated =
        await _updateStoredUserAuthData(_userAuthData);
    return isSuccessfullyAuthenticated;
  }

  Future<bool> tryAutoLogin() async {
    var storedUserAuthDataStr = _localStorageApi.loadFromDisk(UserAuthDataKey);
    if (storedUserAuthDataStr == null) {
      return false;
    }

    UserAuthData storedUserAuthData =
        UserAuthData.fromJson(json.decode(storedUserAuthDataStr));
    if (storedUserAuthData.expiryDate == null ||
        storedUserAuthData.expiryDate!.isBefore(DateTime.now())) {
      return false;
    }
    try {
      await _authenticationApi.checkAccessToken(storedUserAuthData.token!);
      _userAuthData = storedUserAuthData;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    this._userAuthData = null;

    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    bool isRemovedSuccessfully = await _updateStoredUserAuthData(null);
    if (isRemovedSuccessfully) {
      _navigationService.clearStackAndShow(Routes.signinView);
    }
  }

  void configureAutoLogout() {
    if (!this.isAuthenticated)
      throw AuthenticationException(
          message: 'Should not configureAutoLogout unless logged.');

    if (_authTimer != null) _authTimer!.cancel();
    final timeToExpiry =
        _userAuthData!.expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  UserAuthData? get userAuthData {
    if (_userAuthData == null) {
      var storedUserAuthDataStr =
          _localStorageApi.loadFromDisk(UserAuthDataKey);
      if (storedUserAuthDataStr == null) {
        return null;
      }

      _userAuthData = UserAuthData.fromJson(json.decode(storedUserAuthDataStr));
    }
    return _userAuthData;
  }

  Future<bool> _updateStoredUserAuthData(UserAuthData? userAuthData) async {
    if (userAuthData == null) {
      bool isRemovedSuccessfully =
          await _localStorageApi.removeFromDisk(UserAuthDataKey);
      if (!isRemovedSuccessfully) {
        log.e('Unable to remove old user authentication data.');
      }
      return isRemovedSuccessfully;
    }

    bool isSavedSuccessfully = await _localStorageApi.saveToDisk(
        UserAuthDataKey, json.encode(userAuthData.toJson()));

    if (!isSavedSuccessfully) {
      log.e('Unable to save new user authentication data.');
    }

    return isSavedSuccessfully;
  }
}
