// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String PlaceTitleValueKey = 'placeTitle';

mixin $CreateFavoritePlaceView on StatelessWidget {
  final TextEditingController placeTitleController = TextEditingController();
  final FocusNode placeTitleFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    placeTitleController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            PlaceTitleValueKey: placeTitleController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    placeTitleController.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get placeTitleValue => this.formValueMap[PlaceTitleValueKey];

  bool get hasPlaceTitle => this.formValueMap.containsKey(PlaceTitleValueKey);
}

extension Methods on FormViewModel {}
