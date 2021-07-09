import 'package:flutter/material.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/ui/shared/ui_helpers.dart';
import 'package:fretto/ui/widgets/box_button.dart';
import 'package:fretto/ui/widgets/box_input_field.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'mobile_validation_sms_code_view.form.dart';
import 'mobile_validation_sms_code_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'smsCode'),
])
class MobileValidationSMSCodeView extends StatelessWidget
    with $MobileValidationSMSCodeView {
  final String icc;
  final String mobileNumber;

  MobileValidationSMSCodeView(
      {Key? key, required this.icc, required this.mobileNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MobileValidationSMSCodeViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizationDelegate
                .appLocalizations!.mobileValidationSMSCodeTitle),
          ),
          body: SafeArea(
              child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Builder(builder: (ctx) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            AppLocalizationDelegate
                                .appLocalizations!.mobileValidationSMSCodeText,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          verticalSpaceMedium,
                          Form(
                              key: model.formKey,
                              child: BoxInputField(
                                controller: smsCodeController,
                                keyboardType: TextInputType.number,
                                validator: (value) => value != null &&
                                        value.length == 4
                                    ? null
                                    : AppLocalizationDelegate.appLocalizations!
                                        .mobileValidationSMSCodeValidationMessage,
                                textInputAction: TextInputAction.done,
                              )),
                          verticalSpaceRegular,
                          BoxButton(
                            title: AppLocalizationDelegate.appLocalizations!
                                .mobileValidationSMSCodeValidate,
                            busy: model.isBusy,
                            onTap: model.isBusy ? () {} : model.validateSmsCode,
                          ),
                          verticalSpaceMedium,
                          BoxButton(
                            title: AppLocalizationDelegate.appLocalizations!
                                .mobileValidationSMSCodeResend,
                            onTap: model.isBusy
                                ? () {}
                                : () => model.resendSmsCode(icc, mobileNumber),
                          ),
                        ]);
                  })))),
      viewModelBuilder: () => MobileValidationSMSCodeViewModel(),
    );
  }
}
