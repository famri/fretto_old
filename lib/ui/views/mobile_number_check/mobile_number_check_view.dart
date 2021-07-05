import 'package:flutter/material.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/ui/shared/ui_helpers.dart';
import 'package:fretto/ui/widgets/box_button.dart';
import 'package:fretto/ui/widgets/box_drop_down_button_field.dart';
import 'package:fretto/ui/widgets/box_input_field.dart';
import 'package:fretto/utils/validators.dart';
import 'package:stacked/stacked.dart';

import 'mobile_number_check_viewmodel.dart';

class MobileNumberCheckView extends StatelessWidget {
  MobileNumberCheckView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MobileNumberCheckViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Vérification de mobile'),
          ),
          body: SafeArea(
              child: model.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Form(
                                key: model.formKey,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: BoxDropDownButtonField(
                                          elements: model
                                              .data!
                                              .internationalCallingCodes!
                                              .entries
                                              .map<DropdownMenuItemElement>(
                                                  (e) =>
                                                      DropdownMenuItemElement(
                                                          title: e.value.name,
                                                          value: e.key))
                                              .toList(),
                                          onChanged: model.updateIccId,
                                          value: model.iccId,
                                        ),
                                      ),
                                      horizontalSpaceTiny,
                                      Expanded(
                                          flex: 6,
                                          child: BoxInputField(
                                            controller:
                                                model.mobileNumberController,
                                            validator: (phoneNumber) =>
                                                Validators.phoneNumberValidator(
                                                    phoneNumber, context),
                                            placeholder:
                                                AppLocalizations.of(context)!
                                                    .signUpMobileNumberLabel,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                          ))
                                    ])),
                            verticalSpaceRegular,
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                child: BoxButton(
                                  title: 'Vérifier',
                                  onTap: model.checkMobile,
                                ))
                          ])))),
      viewModelBuilder: () => MobileNumberCheckViewModel(),
    );
  }
}
