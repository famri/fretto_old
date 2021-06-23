import 'dart:async';

import 'package:fretto/api/authentication_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/exceptions/authentication_exception.dart';
import 'package:fretto/models/bearer_token_info.dart';
import 'package:fretto/models/user_auth_data.dart';
import 'package:fretto/models/user_info.dart';
import 'package:fretto/services/country_service.dart';
import 'package:fretto/services/local_storage_service.dart';
import 'package:fretto/utils/validators.dart';

class AuthenticationService {
  final AuthenticationApi _authenticationApi = locator<AuthenticationApi>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final CountryService _countryService = locator<CountryService>();

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

  Future<void> signin(String username, String password) async {
    // if username is mobile number then try to add international calling code
    if (Validators.isMobileNumber(username)) {
      if (_localStorageService.applicationSettings != null) {
        String? countryIcc = _countryService.getCountryInternationalCallingCode(
            _localStorageService.applicationSettings!.userCountryId);
        if (countryIcc != null) {
          username = countryIcc + '_' + username;
        }
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
    _localStorageService.userAuthData = _userAuthData;
  }

  Future<void> signup(
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
    _localStorageService.userAuthData = _userAuthData;
  }

  Future<bool> tryAutoLogin() async {
    _userAuthData = _localStorageService.userAuthData;

    if (_userAuthData == null ||
        _userAuthData!.expiryDate == null ||
        _userAuthData!.expiryDate!.isBefore(DateTime.now())) {
      return false;
    }

    return true;
  }

  Future<void> logout() async {
    this._userAuthData = null;
    _localStorageService.userAuthData = null;
    if (_authTimer != null) _authTimer!.cancel();
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
}
