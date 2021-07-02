import 'package:flutter/material.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/ui/shared/ui_helpers.dart';
import 'package:fretto/ui/widgets/box_button.dart';
import 'package:fretto/ui/widgets/box_drop_down_button_field.dart';
import 'package:fretto/ui/widgets/box_text.dart';
import 'package:stacked/stacked.dart';

import './application_settings_viewmodel.dart';

class ApplicationSettingsView extends StatelessWidget {
  const ApplicationSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ApplicationSettingsViewModel>.reactive(
      onModelReady: (model) => model.loadCountriesAndUserLocales(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(
                AppLocalizations.of(context)!.applicationSettingsAppBarTitle),
          ),
          body: SafeArea(
              child: model.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : model.hasError
                      ? Center(
                          child: Text(
                              'An error occured while preparing application settings.'))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                              Expanded(
                                  child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 2,
                                                        child: BoxText.subheading(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .applicationSettingsCountryText)),
                                                    Expanded(
                                                        flex: 5,
                                                        child:
                                                            BoxDropDownButtonField(
                                                          value: model
                                                              .countryController,
                                                          elements: model
                                                              .countries
                                                              .map<DropdownMenuItemElement>((country) =>
                                                                  DropdownMenuItemElement(
                                                                      title: country
                                                                          .name,
                                                                      value:
                                                                          country
                                                                              .id,
                                                                      trailing: SizedBox(
                                                                          width: 25,
                                                                          height: 25,
                                                                          child: Image.network(
                                                                            'https://' +
                                                                                model.appDomain +
                                                                                '/' +
                                                                                model.appName +
                                                                                country.flagPath,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ))))
                                                              .toList(),
                                                          onChanged:
                                                              (int? value) {
                                                            model.updateCountry(
                                                                value);
                                                          },
                                                        )),
                                                  ],
                                                ),
                                                verticalSpaceRegular,
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 2,
                                                        child: BoxText.subheading(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .applicationSettingsLanguageText)),
                                                    Expanded(
                                                      flex: 5,
                                                      child: BoxDropDownButtonField(
                                                          value: model
                                                              .localeContoller,
                                                          elements: model
                                                              .userLocales
                                                              .map<DropdownMenuItemElement>((locale) =>
                                                                  DropdownMenuItemElement(
                                                                      title: locale
                                                                          .name,
                                                                      value: locale
                                                                          .id))
                                                              .toList(),
                                                          onChanged: (value) =>
                                                              model
                                                                  .updateLocaleController(
                                                                      value)),
                                                    ),
                                                  ],
                                                ),
                                                verticalSpaceRegular,
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 2,
                                                        child: BoxText.subheading(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .applicationSettingsTimeZoneText)),
                                                    Expanded(
                                                        flex: 5,
                                                        child:
                                                            BoxDropDownButtonField(
                                                                value: model
                                                                    .timeZoneController,
                                                                elements: model
                                                                    .countries
                                                                    .firstWhere((element) =>
                                                                        element
                                                                            .id ==
                                                                        model
                                                                            .countryController)
                                                                    .timeZones
                                                                    .map<DropdownMenuItemElement>(
                                                                        (timezone) =>
                                                                            DropdownMenuItemElement(
                                                                              title: timezone.gmtOffset,
                                                                              value: timezone.id,
                                                                            ))
                                                                    .toList(),
                                                                onChanged:
                                                                    (value) {
                                                                  model.updateTimeZoneController(
                                                                      value);
                                                                })),
                                                  ],
                                                ),
                                                verticalSpaceMedium,
                                                Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 25.0,
                                                            vertical: 30.0),
                                                    child: BoxButton(
                                                      title:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .saveButtonText,
                                                      onTap: () =>
                                                          model.saveSettings(
                                                              context),
                                                    ))
                                              ])))),
                            ]))),
      viewModelBuilder: () => ApplicationSettingsViewModel(),
    );
  }
}
