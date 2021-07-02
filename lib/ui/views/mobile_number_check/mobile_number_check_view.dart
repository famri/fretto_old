import 'package:flutter/material.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/ui/shared/ui_helpers.dart';
import 'package:fretto/ui/widgets/box_button.dart';
import 'package:fretto/ui/widgets/box_input_field.dart';
import 'package:fretto/ui/widgets/box_input_field_read_only.dart';
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
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Vérification de mobile'),
          ),
          body: SafeArea(
              child: model.isBusy
                  ? CircularProgressIndicator()
                  : Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Form(
                          key: model.formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: BoxInputFieldReadOnly(
                                            initialValue: "(${model.icc})"),
                                      ),
                                      horizontalSpaceTiny,
                                      Expanded(
                                          flex: 6,
                                          child: BoxInputField(
                                            controller: mobileNumberController,
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
                                    ]),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                30,
                                        height: 50.0,
                                        child: BoxButton(
                                          title: 'Vérifier',
                                          onTap: model.checkMobile,
                                        )))
                              ]))))),
      viewModelBuilder: () => MobileNumberCheckViewModel(),
    );
  }
}
