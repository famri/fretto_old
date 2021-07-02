// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String MobileNumberValueKey = 'mobileNumber';

mixin $MobileNumberCheckView on StatelessWidget {
  final TextEditingController mobileNumberController = TextEditingController();
  final FocusNode mobileNumberFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    mobileNumberController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            MobileNumberValueKey: mobileNumberController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    mobileNumberController.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get mobileNumberValue => this.formValueMap[MobileNumberValueKey];

  bool get hasMobileNumber =>
      this.formValueMap.containsKey(MobileNumberValueKey);
}

extension Methods on FormViewModel {}
