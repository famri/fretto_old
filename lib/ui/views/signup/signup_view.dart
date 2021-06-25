import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/ui/shared/ui_helpers.dart';
import 'package:fretto/ui/widgets/box_button.dart';
import 'package:fretto/ui/widgets/box_date_input_field.dart';
import 'package:fretto/ui/widgets/box_drop_down_button_field.dart';
import 'package:fretto/ui/widgets/box_input_field.dart';
import 'package:fretto/ui/widgets/box_input_field_read_only.dart';
import 'package:fretto/utils/validators.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'signup_view.form.dart';
import 'signup_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'firstname'),
  FormTextField(name: 'lastname'),
  FormTextField(name: 'dateOfBirth'),
  FormTextField(name: 'email'),
  FormTextField(name: 'mobileNumber'),
  FormTextField(name: 'password', isPassword: true),
  FormTextField(name: 'passwordConfirmation', isPassword: true),
])
class SignupView extends StatelessWidget with $SignupView {
  final bool isTransporter;
  SignupView({Key? key, required this.isTransporter}) : super(key: key);

  @override
  void disposeForm() {
    firstnameFocusNode.dispose();
    lastnameFocusNode.dispose();
    dateOfBirthFocusNode.dispose();
    emailFocusNode.dispose();
    mobileNumberFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordConfirmationFocusNode.dispose();

    super.disposeForm();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      onModelReady: (model) => initialize(model),
      onDispose: disposeForm,
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.authenticationSignupText),
          centerTitle: true,
        ),
        body: SafeArea(
            child: model.isBusy
                ? Center(child: CircularProgressIndicator())
                : Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    child: ListView(
                      children: <Widget>[
                        Form(
                            key: model.formKey,
                            child: Column(
                              children: [
                                BoxDropDownButtonField(
                                  value: model.genderController,
                                  elements: model.genders
                                      .map<DropdownMenuItemElement>(
                                          (e) => DropdownMenuItemElement(
                                                title: e.name,
                                                value: e.id,
                                              ))
                                      .toList(),
                                  onChanged: (int? value) {
                                    model.updateGender(value);
                                  },
                                ),
                                verticalSpaceRegular,
                                BoxInputField(
                                  controller: lastnameController,
                                  validator: (lastname) =>
                                      Validators.lengthValidator(
                                          lastname,
                                          AppLocalizations.of(context)!
                                              .signUpLastnameLabel,
                                          context,
                                          2,
                                          15),
                                  placeholder: AppLocalizations.of(context)!
                                      .signUpLastnameLabel,
                                  focusNode: lastnameFocusNode,
                                  textInputAction: TextInputAction.next,
                                ),
                                verticalSpaceRegular,
                                BoxInputField(
                                  controller: firstnameController,
                                  validator: (firstname) =>
                                      Validators.lengthValidator(
                                          firstname,
                                          AppLocalizations.of(context)!
                                              .signUpFirstnameLabel,
                                          context,
                                          2,
                                          15),
                                  placeholder: AppLocalizations.of(context)!
                                      .signUpFirstnameLabel,
                                  textInputAction: TextInputAction.next,
                                ),
                                verticalSpaceRegular,
                                BoxDateInputField(
                                    controller: dateOfBirthController,
                                    placeholder: AppLocalizations.of(context)!
                                        .signUpBirthDateLabel,
                                    initialDate: DateTime.now()
                                        .subtract(Duration(days: 364 * 18)),
                                    firstDate: DateTime.now()
                                        .subtract(Duration(days: 364 * 120)),
                                    lastDate: DateTime.now()
                                        .subtract(Duration(days: 364 * 16)),
                                    focusNode: dateOfBirthFocusNode,
                                    requestNextFocus: true,
                                    validator: (value) =>
                                        Validators.ageValidator(value, context,
                                            minAge: 18, maxAge: 100)),
                                verticalSpaceRegular,
                                BoxInputField(
                                  controller: emailController,
                                  validator: (email) =>
                                      Validators.emailValidator(email, context),
                                  placeholder: AppLocalizations.of(context)!
                                      .signUpEmailLabel,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                verticalSpaceRegular,
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
                                verticalSpaceRegular,
                                BoxInputField(
                                    controller: passwordController,
                                    validator: (password) =>
                                        Validators.passwordValidator(
                                            password, context),
                                    placeholder: AppLocalizations.of(context)!
                                        .signUpPasswordLabel,
                                    password: true,
                                    textInputAction: TextInputAction.next,
                                    focusNode: passwordFocusNode),
                                verticalSpaceRegular,
                                BoxInputField(
                                  controller: passwordConfirmationController,
                                  validator: (passwordConfirmation) =>
                                      model.validatePasswordConfirmation(
                                          passwordConfirmation, context),
                                  placeholder: AppLocalizations.of(context)!
                                      .signUpConfirmPasswordLabel,
                                  password: true,
                                  textInputAction: TextInputAction.done,
                                  focusNode: passwordConfirmationFocusNode,
                                ),
                                verticalSpaceRegular,
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      AppLocalizations.of(context)!
                                          .signUpSubscribeNewsletterText,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.lightBlue),
                                      softWrap: true,
                                    )),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: Checkbox(
                                          value: model.receiveNewsLetter,
                                          onChanged:
                                              model.updateReceiveNewsLetter,
                                        )),
                                  ],
                                )
                              ],
                            )),
                        verticalSpaceRegular,
                        if (model.hasErrorForKey(model.signupBusyObj))
                          Text(
                            model.getErrorMessage(context),
                            style: TextStyle(color: Colors.red),
                          ),
                        verticalSpaceRegular,
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15.0),
                          child: !model.busy(model.signupBusyObj)
                              ? BoxButton(
                                  title: AppLocalizations.of(context)!
                                      .authenticationSignupText,
                                  onTap: model.signup,
                                )
                              : BoxButton(
                                  busy: true,
                                  title: AppLocalizations.of(context)!
                                      .authenticationSignupText,
                                  onTap: () {}),
                        ),
                        verticalSpaceRegular,
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 12.0,
                                  height: 2,
                                  color: Color.fromRGBO(0, 70, 82, 1)),
                              children: <TextSpan>[
                                TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .signUpTOS1),
                                TextSpan(
                                  text:
                                      AppLocalizations.of(context)!.signUpTOS2,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      await launch(
                                          'https://www.fretto.com/about-us/terms-and-conditions');
                                    },
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.lightBlue),
                                ),
                                TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .signUpTOS3),
                                TextSpan(
                                  text:
                                      AppLocalizations.of(context)!.signUpTOS4,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      await launch(
                                          'https://www.fretto.com/about-us/privacy-policy');
                                    },
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.lightBlue),
                                ),
                              ]),
                        ),
                      ],
                    ))),
      ),
      viewModelBuilder: () => SignupViewModel(),
    );
  }

  Future<void> initialize(SignupViewModel model) async {
    listenToFormUpdated(model);
    await model.loadGenders();
    model.isTransporter = isTransporter;
  }
}
