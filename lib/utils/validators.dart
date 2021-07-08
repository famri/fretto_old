import 'package:flutter/cupertino.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:intl/intl.dart';

class Validators {
  static RegExp emailExp = RegExp(
      r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$');

  static RegExp phoneNumberExp = RegExp(r'^([0-9]{8,10})$');

  static String? loginValidator(String? login) {
    bool isOk = true;
    if (login != null) {
      Iterable<RegExpMatch> matches = emailExp.allMatches(login);
      if (matches.isEmpty) {
        matches = phoneNumberExp.allMatches(login);
        if (matches.isEmpty) {
          isOk = false;
        }
      }
    }
    return isOk ? null : AppLocalizationDelegate.appLocalizations!.loginValidatorMessage;
  }

  static String? emailValidator(String? email) {
    if (email == null) {
      return AppLocalizationDelegate.appLocalizations!.emailValidatorMessage;
    }
    Iterable<RegExpMatch> matches = emailExp.allMatches(email);
    if (matches.isEmpty) {
      return AppLocalizationDelegate.appLocalizations!.emailValidatorMessage;
    }
    return null;
  }

  static String? phoneNumberValidator(
      String? phoneNumber) {
    if (phoneNumber == null) {
      return AppLocalizationDelegate.appLocalizations!.emailValidatorMessage;
    }
    Iterable<RegExpMatch> matches = phoneNumberExp.allMatches(phoneNumber);
    if (matches.isEmpty) {
      return AppLocalizationDelegate.appLocalizations!.phoneValidatorMessage;
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    return (password != null && password.length >= 8)
        ? null
        : AppLocalizationDelegate.appLocalizations!.passwordValidatorMessage;
  }

  static String? dateBeforeValidator(
      DateTime beforeDate, DateTime afterDate) {
    return (beforeDate.isBefore(afterDate))
        ? null
        :AppLocalizationDelegate.appLocalizations!.dateBeforeValidatorMessage;
  }

  static String? ageValidator(String? value,
      {int minAge = 18, int maxAge = 100}) {
    if (value == null || value.isEmpty)
      return AppLocalizationDelegate.appLocalizations!.ageEmptyValidatorMessage;
    DateTime pickedDate = DateFormat('dd/MM/yyyy').parse(value);
    if (pickedDate
        .isAfter(DateTime.now().subtract(Duration(days: 365 * minAge)))) {
      return AppLocalizationDelegate.appLocalizations!.ageMinValidatorMessage;
    }
    if (pickedDate
        .isBefore(DateTime.now().subtract(Duration(days: 365 * maxAge)))) {
      return AppLocalizationDelegate.appLocalizations!.ageMaxValidatorMessage;
    }
    return null;
  }

  static String? lengthValidator(
      String? value, String fieldName, int min, int max) {
    if (value == null)
      return AppLocalizationDelegate.appLocalizations!
          .nullLengthValidationMessage(fieldName, min, max);
    if (value.length < min)
      return AppLocalizationDelegate.appLocalizations!
          .minLengthValidationMessage(fieldName, min);
    if (value.length > max)
      return AppLocalizationDelegate.appLocalizations!
          .minLengthValidationMessage(fieldName, max);

    return null;
  }

  static bool isMobileNumber(String? mobileNumber) {
    if (mobileNumber == null) {
      return false;
    }
    Iterable<RegExpMatch> matches = phoneNumberExp.allMatches(mobileNumber);

    return matches.isNotEmpty;
  }
}
