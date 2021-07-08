import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/models/geo_place_dto.dart';
import 'package:fretto/models/place_suggestion.dart';
import 'package:fretto/ui/shared/colors.dart';
import 'package:fretto/ui/shared/styles.dart';
import 'package:fretto/ui/shared/ui_helpers.dart';
import 'package:fretto/ui/views/favorite_places/favorite_places_view.dart';
import 'package:fretto/ui/widgets/box_button.dart';
import 'package:fretto/ui/widgets/box_drop_down_button_field.dart';
import 'package:fretto/ui/widgets/box_input_field.dart';
import 'package:fretto/ui/widgets/box_number_input.dart';
import 'package:fretto/ui/widgets/locality_search.dart';
import 'package:fretto/utils/engine_type_helper.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'journey_creation_view.form.dart';
import 'journey_creation_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'departure'),
  FormTextField(name: 'arrival'),
  FormTextField(name: 'date'),
  FormTextField(name: 'time'),
  FormTextField(name: 'handlers'),
  FormTextField(name: 'description')
])
class JourneyCreationView extends StatelessWidget with $JourneyCreationView {
  bool get isEditing => journeyId != null;
  final int? journeyId;
  final FocusNode _engineTypeFocusNode = FocusNode();

  JourneyCreationView({Key? key, this.journeyId}) : super(key: key);

  void dispose() {
    _engineTypeFocusNode.dispose();

    super.disposeForm();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JourneyCreationViewModel>.reactive(
      onDispose: dispose,
      disposeViewModel: false,
      onModelReady: (model) => _initialize(model),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.createJourneyAppBarTitle),
            actions: [],
          ),
          body: SafeArea(
            child: model.isBusy
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        child: Column(children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .createJourneyHeaderText,
                                style: heading2Style.copyWith(
                                    color: kcPetroliumBlue),
                              )),
                          verticalSpaceMedium,
                          Form(
                            key: model.formKey,
                            child: Column(
                              children: [
                                Row(children: [
                                  Expanded(
                                    flex: 9,
                                    child: BoxInputField(
                                      label: AppLocalizations.of(context)!
                                          .createJourneyDepartureLabel,
                                      controller: departureController,
                                      placeholder: AppLocalizations.of(context)!
                                          .createJourneyDepartureLabel,
                                      textInputAction: TextInputAction.next,
                                      onTap: () => _showDeparturePlaceSearch(
                                          context, model),
                                      validator: (value) => value != null &&
                                              value.isNotEmpty
                                          ? null
                                          : AppLocalizations.of(context)!
                                              .createJourneyDepartureValidatorMessage,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        alignment: Alignment.centerLeft,
                                        icon: Icon(Icons.star_rate_rounded,
                                            color: Colors.amber),
                                        onPressed: () =>
                                            _showDepartureFavoritePlaces(
                                                context, model),
                                      ))
                                ]),
                                verticalSpaceSmall,
                                Row(children: [
                                  Expanded(
                                      flex: 9,
                                      child: BoxInputField(
                                        label: AppLocalizations.of(context)!
                                            .createJourneyArrivalLabel,
                                        controller: arrivalController,
                                        focusNode: arrivalFocusNode,
                                        placeholder:
                                            AppLocalizations.of(context)!
                                                .createJourneyArrivalLabel,
                                        textInputAction: TextInputAction.next,
                                        onTap: () => _showArrivalPlaceSearch(
                                            context, model),
                                        validator: (value) => value != null &&
                                                value.isNotEmpty
                                            ? null
                                            : AppLocalizations.of(context)!
                                                .createJourneyArrivalValidatorMessage,
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        alignment: Alignment.centerLeft,
                                        icon: Icon(Icons.star_rate_rounded,
                                            color: Colors.amber),
                                        onPressed: () =>
                                            _showArrivalFavoritePlaces(
                                                context, model),
                                      ))
                                ]),
                                verticalSpaceSmall,
                                BoxDropDownButtonField(
                                    label: AppLocalizations.of(context)!
                                        .createJourneyVehiculeLabel,
                                    hintText: AppLocalizations.of(context)!
                                        .createJourneyVehiculeLabel,
                                    focusNode: _engineTypeFocusNode,
                                    nextFocusNode: dateFocusNode,
                                    value: model.engineTypeController,
                                    validator: (value) => value != null
                                        ? null
                                        : AppLocalizations.of(context)!
                                            .createJourneyVehiculeValidatorMessage,
                                    elements: model.engineTypes
                                        .map<DropdownMenuItemElement>(
                                            (engineType) =>
                                                DropdownMenuItemElement(
                                                    title: engineType.name,
                                                    value: engineType.id,
                                                    trailing: Icon(
                                                      EngineTypeHelper
                                                          .getEngineTypeIconData(
                                                              engineType.code),
                                                      color: Colors.lightBlue,
                                                    )))
                                        .toList(),
                                    onChanged: (int? value) {
                                      model.updateEngineType(value);
                                    }),
                                verticalSpaceSmall,
                                BoxInputField(
                                  label: AppLocalizations.of(context)!
                                      .createJourneyDateLabel,
                                  placeholder: AppLocalizations.of(context)!
                                      .createJourneyDateLabel,
                                  controller: dateController,
                                  focusNode: dateFocusNode,
                                  validator: (value) => value != null &&
                                          value.isNotEmpty
                                      ? null
                                      : AppLocalizations.of(context)!
                                          .createJourneyDateValidatorMessage,
                                  onTap: () => _selectDate(context, model),
                                ),
                                verticalSpaceSmall,
                                BoxInputField(
                                  label: AppLocalizations.of(context)!
                                      .createJourneyTimeLabel,
                                  placeholder: AppLocalizations.of(context)!
                                      .createJourneyTimeLabel,
                                  controller: timeController,
                                  validator: (value) => value != null &&
                                          value.isNotEmpty
                                      ? null
                                      : AppLocalizations.of(context)!
                                          .createJourneyTimeValidatorMessage,
                                  focusNode: timeFocusNode,
                                  onTap: () => _selectTime(context, model),
                                ),
                                verticalSpaceSmall,
                                BoxNumberInput(
                                    label: AppLocalizations.of(context)!
                                        .createJourneyHandlersLabel,
                                    initialValue: model.workers ?? 0,
                                    onChanged: (value) =>
                                        model.updateWorkers(value),
                                    focusNode: handlersFocusNode),
                                verticalSpaceSmall,
                                BoxInputField(
                                    controller: descriptionController,
                                    label: AppLocalizations.of(context)!
                                        .clientJourneyDetailsDescriptionLabel,
                                    placeholder: AppLocalizations.of(context)!
                                        .createJourneyDescriptionLabel,
                                    maxLines: 3,
                                    validator: (value) => value != null &&
                                            value.isNotEmpty
                                        ? null
                                        : AppLocalizations.of(context)!
                                            .createJourneyDescriptionValidatorMessage,
                                    textInputAction: TextInputAction.done),
                                if (model.hasError)
                                  Text(
                                    model.modelError.toString(),
                                    style: TextStyle(color: Colors.red),
                                  ),
                              ],
                            ),
                          ),
                          verticalSpaceMedium,
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 15.0),
                            child: !model.busy(model.createJourneyBusyObj)
                                ? BoxButton(
                                    title: isEditing
                                        ? AppLocalizations.of(context)!
                                            .saveButtonText
                                        : AppLocalizations.of(context)!
                                            .publishButtonText,
                                    onTap: isEditing
                                        ? () {
                                            model.updateJourneyRequest(
                                                journeyId);
                                          }
                                        : () {
                                            model.createJourneyRequest();
                                          },
                                  )
                                : BoxButton(
                                    busy: true,
                                    title: AppLocalizations.of(context)!
                                        .publishButtonText,
                                    onTap: () {}),
                          ),
                        ]))),
          )),
      viewModelBuilder: () => locator<JourneyCreationViewModel>(),
    );
  }

  Future<void> _initialize(JourneyCreationViewModel model) async {
    await model.loadEngineTypes();
    arrivalController.text = model.formValueMap[ArrivalValueKey] ?? '';
    departureController.text = model.formValueMap[DepartureValueKey] ?? '';

    dateController.text = model.formValueMap[DateValueKey] ?? '';
    timeController.text = model.formValueMap[TimeValueKey] ?? '';
    descriptionController.text = model.formValueMap[DescriptionValueKey] ?? '';
    listenToFormUpdated(model);
  }

  Future<void> _selectDate(
      BuildContext context, JourneyCreationViewModel model) async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: now,
        lastDate: now.add(Duration(days: 93)));
    if (picked != null) {
      model.updateSelectedDate(picked);
      dateController.text = DateFormat.yMd().format(picked);
      FocusScope.of(context).requestFocus(timeFocusNode);
    }
  }

  Future<void> _selectTime(
      BuildContext context, JourneyCreationViewModel model) async {
    DateTime now = DateTime.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: TimeOfDay.fromDateTime(now),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null) {
      model.updateSelectedTime(picked);

      timeController.text = picked.hour.toString().padLeft(2, '0') +
          ' : ' +
          picked.minute.toString().padLeft(2, '0');
      FocusScope.of(context).requestFocus(handlersFocusNode);
    }
  }

  Future<void> _showDeparturePlaceSearch(
      BuildContext context, JourneyCreationViewModel model) async {
    final PlaceSuggestion? placeSuggestion = await showSearch<PlaceSuggestion?>(
      context: context,
      delegate: LocalitySearch(),
    );
    if (placeSuggestion != null) {
      model.updateDeparturePlaceIdAndType(
          placeSuggestion.id, placeSuggestion.type);

      FocusScope.of(context).requestFocus(arrivalFocusNode);
      departureController.text =
          LocalitySearch.buildPlaceSuggestionTitle(placeSuggestion);
    }
  }

  Future<void> _showArrivalPlaceSearch(
      BuildContext context, JourneyCreationViewModel model) async {
    final PlaceSuggestion? placeSuggestion = await showSearch<PlaceSuggestion?>(
      context: context,
      delegate: LocalitySearch(),
    );
    if (placeSuggestion != null) {
      model.updateArrivalPlaceIdAndType(
          placeSuggestion.id, placeSuggestion.type);

      FocusScope.of(context).requestFocus(_engineTypeFocusNode);
      arrivalController.text =
          LocalitySearch.buildPlaceSuggestionTitle(placeSuggestion);
    }
  }

  void _showDepartureFavoritePlaces(
      BuildContext context, JourneyCreationViewModel model) async {
    GeoPlaceDto? departureGeoPlace =
        await Navigator.of(context).push<GeoPlaceDto>(
      MaterialPageRoute(builder: (context) => FavoritePlacesView()),
    );
    if (departureGeoPlace != null) {
      model.updateDeparturePlaceIdAndType(departureGeoPlace.id, 'geo-place');

      departureController.text = departureGeoPlace.name;

      FocusScope.of(context).requestFocus(arrivalFocusNode);
    }
  }

  void _showArrivalFavoritePlaces(
      BuildContext context, JourneyCreationViewModel model) async {
    GeoPlaceDto? arrivalGeoPlace =
        await Navigator.of(context).push<GeoPlaceDto>(
      MaterialPageRoute(builder: (context) => FavoritePlacesView()),
    );
    if (arrivalGeoPlace != null) {
      model.updateDeparturePlaceIdAndType(arrivalGeoPlace.id, 'geo-place');

      departureController.text = arrivalGeoPlace.name;

      FocusScope.of(context).requestFocus(_engineTypeFocusNode);
    }
  }
}
