// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String FirstnameValueKey = 'firstname';
const String LastnameValueKey = 'lastname';
const String DateOfBirthValueKey = 'dateOfBirth';
const String EmailValueKey = 'email';
const String MobileNumberValueKey = 'mobileNumber';
const String PasswordValueKey = 'password';
const String PasswordConfirmationValueKey = 'passwordConfirmation';

mixin $SignupView on StatelessWidget {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final FocusNode firstnameFocusNode = FocusNode();
  final FocusNode lastnameFocusNode = FocusNode();
  final FocusNode dateOfBirthFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode mobileNumberFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode passwordConfirmationFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    firstnameController.addListener(() => _updateFormData(model));
    lastnameController.addListener(() => _updateFormData(model));
    dateOfBirthController.addListener(() => _updateFormData(model));
    emailController.addListener(() => _updateFormData(model));
    mobileNumberController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    passwordConfirmationController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            FirstnameValueKey: firstnameController.text,
            LastnameValueKey: lastnameController.text,
            DateOfBirthValueKey: dateOfBirthController.text,
            EmailValueKey: emailController.text,
            MobileNumberValueKey: mobileNumberController.text,
            PasswordValueKey: passwordController.text,
            PasswordConfirmationValueKey: passwordConfirmationController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    firstnameController.dispose();
    lastnameController.dispose();
    dateOfBirthController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get firstnameValue => this.formValueMap[FirstnameValueKey];
  String? get lastnameValue => this.formValueMap[LastnameValueKey];
  String? get dateOfBirthValue => this.formValueMap[DateOfBirthValueKey];
  String? get emailValue => this.formValueMap[EmailValueKey];
  String? get mobileNumberValue => this.formValueMap[MobileNumberValueKey];
  String? get passwordValue => this.formValueMap[PasswordValueKey];
  String? get passwordConfirmationValue =>
      this.formValueMap[PasswordConfirmationValueKey];

  bool get hasFirstname => this.formValueMap.containsKey(FirstnameValueKey);
  bool get hasLastname => this.formValueMap.containsKey(LastnameValueKey);
  bool get hasDateOfBirth => this.formValueMap.containsKey(DateOfBirthValueKey);
  bool get hasEmail => this.formValueMap.containsKey(EmailValueKey);
  bool get hasMobileNumber =>
      this.formValueMap.containsKey(MobileNumberValueKey);
  bool get hasPassword => this.formValueMap.containsKey(PasswordValueKey);
  bool get hasPasswordConfirmation =>
      this.formValueMap.containsKey(PasswordConfirmationValueKey);
}

extension Methods on FormViewModel {}
