// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String SmsCodeValueKey = 'smsCode';

mixin $MobileValidationSMSCodeView on StatelessWidget {
  final TextEditingController smsCodeController = TextEditingController();
  final FocusNode smsCodeFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    smsCodeController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            SmsCodeValueKey: smsCodeController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    smsCodeController.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get smsCodeValue => this.formValueMap[SmsCodeValueKey];

  bool get hasSmsCode => this.formValueMap.containsKey(SmsCodeValueKey);
}

extension Methods on FormViewModel {}
