import 'package:flutter/material.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/ui/shared/ui_helpers.dart';
import 'package:fretto/ui/widgets/box_button.dart';
import 'package:fretto/ui/widgets/box_drop_down_button_field.dart';
import 'package:fretto/ui/widgets/box_input_field.dart';
import 'package:fretto/utils/validators.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'mobile_number_check_view.form.dart';
import 'mobile_number_check_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'mobileNumber'),
])
class MobileNumberCheckView extends StatelessWidget
    with $MobileNumberCheckView {
  MobileNumberCheckView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MobileNumberCheckViewModel>.reactive(
      onModelReady: (model) => _initialize(model),
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
                                            controller: mobileNumberController,
                                            validator: (phoneNumber) =>
                                                Validators.phoneNumberValidator(
                                                    phoneNumber),
                                            placeholder:
                                                AppLocalizations.of(context)!
                                                    .signUpMobileNumberLabel,
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: TextInputType.number,
                                          ))
                                    ])),
                            verticalSpaceRegular,
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                child: BoxButton(
                                  title: 'Confirmer',
                                  onTap: model.checkMobile,
                                ))
                          ])))),
      viewModelBuilder: () => MobileNumberCheckViewModel(),
    );
  }

  Future<void> _initialize(MobileNumberCheckViewModel model) async {
    listenToFormUpdated(model);
    model.setBusy(true);
    await model.init();
    mobileNumberController.text = model.mobileNumber!;
    model.setBusy(false);
  }
}
