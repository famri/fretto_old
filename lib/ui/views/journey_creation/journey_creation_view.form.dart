// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String DepartureValueKey = 'departure';
const String ArrivalValueKey = 'arrival';
const String DateValueKey = 'date';
const String TimeValueKey = 'time';
const String HandlersValueKey = 'handlers';
const String DescriptionValueKey = 'description';

mixin $JourneyCreationView on StatelessWidget {
  final TextEditingController departureController = TextEditingController();
  final TextEditingController arrivalController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController handlersController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FocusNode departureFocusNode = FocusNode();
  final FocusNode arrivalFocusNode = FocusNode();
  final FocusNode dateFocusNode = FocusNode();
  final FocusNode timeFocusNode = FocusNode();
  final FocusNode handlersFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    departureController.addListener(() => _updateFormData(model));
    arrivalController.addListener(() => _updateFormData(model));
    dateController.addListener(() => _updateFormData(model));
    timeController.addListener(() => _updateFormData(model));
    handlersController.addListener(() => _updateFormData(model));
    descriptionController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            DepartureValueKey: departureController.text,
            ArrivalValueKey: arrivalController.text,
            DateValueKey: dateController.text,
            TimeValueKey: timeController.text,
            HandlersValueKey: handlersController.text,
            DescriptionValueKey: descriptionController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    departureController.dispose();
    arrivalController.dispose();
    dateController.dispose();
    timeController.dispose();
    handlersController.dispose();
    descriptionController.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get departureValue => this.formValueMap[DepartureValueKey];
  String? get arrivalValue => this.formValueMap[ArrivalValueKey];
  String? get dateValue => this.formValueMap[DateValueKey];
  String? get timeValue => this.formValueMap[TimeValueKey];
  String? get handlersValue => this.formValueMap[HandlersValueKey];
  String? get descriptionValue => this.formValueMap[DescriptionValueKey];

  bool get hasDeparture => this.formValueMap.containsKey(DepartureValueKey);
  bool get hasArrival => this.formValueMap.containsKey(ArrivalValueKey);
  bool get hasDate => this.formValueMap.containsKey(DateValueKey);
  bool get hasTime => this.formValueMap.containsKey(TimeValueKey);
  bool get hasHandlers => this.formValueMap.containsKey(HandlersValueKey);
  bool get hasDescription => this.formValueMap.containsKey(DescriptionValueKey);
}

extension Methods on FormViewModel {}
