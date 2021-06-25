import 'package:flutter/cupertino.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:intl/intl.dart';

class Validators {
  static RegExp emailExp = RegExp(
      r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$');

  static RegExp phoneNumberExp = RegExp(r'^([0-9]{8,10})$');

  static String? loginValidator(String? login, BuildContext context) {
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
    return isOk ? null : AppLocalizations.of(context)!.loginValidatorMessage;
  }

  static String? emailValidator(String? email, BuildContext context) {
    if (email == null) {
      return AppLocalizations.of(context)!.emailValidatorMessage;
    }
    Iterable<RegExpMatch> matches = emailExp.allMatches(email);
    if (matches.isEmpty) {
      return AppLocalizations.of(context)!.emailValidatorMessage;
    }
    return null;
  }

  static String? phoneNumberValidator(
      String? phoneNumber, BuildContext context) {
    if (phoneNumber == null) {
      return AppLocalizations.of(context)!.emailValidatorMessage;
    }
    Iterable<RegExpMatch> matches = phoneNumberExp.allMatches(phoneNumber);
    if (matches.isEmpty) {
      return AppLocalizations.of(context)!.phoneValidatorMessage;
    }
    return null;
  }

  static String? passwordValidator(String? password, BuildContext context) {
    return (password != null && password.length >= 8)
        ? null
        : AppLocalizations.of(context)!.passwordValidatorMessage;
  }

  static String? dateBeforeValidator(
      DateTime beforeDate, DateTime afterDate, BuildContext context) {
    return (beforeDate.isBefore(afterDate))
        ? null
        : AppLocalizations.of(context)!.dateBeforeValidatorMessage;
  }

  static String? ageValidator(String? value, BuildContext context,
      {int minAge = 18, int maxAge = 100}) {
    if (value == null || value.isEmpty)
      return AppLocalizations.of(context)!.ageEmptyValidatorMessage;
    DateTime pickedDate = DateFormat('dd/MM/yyyy').parse(value);
    if (pickedDate
        .isAfter(DateTime.now().subtract(Duration(days: 365 * minAge)))) {
      return AppLocalizations.of(context)!.ageMinValidatorMessage;
    }
    if (pickedDate
        .isBefore(DateTime.now().subtract(Duration(days: 365 * maxAge)))) {
      return AppLocalizations.of(context)!.ageMaxValidatorMessage;
    }
    return null;
  }

  static String? lengthValidator(
      String? value, String fieldName, BuildContext context, int min, int max) {
    if (value == null)
      return AppLocalizations.of(context)!
          .nullLengthValidationMessage(fieldName, min, max);
    if (value.length < min)
      return AppLocalizations.of(context)!
          .minLengthValidationMessage(fieldName, min);
    if (value.length > max)
      return AppLocalizations.of(context)!
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
