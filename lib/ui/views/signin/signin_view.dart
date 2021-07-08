import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/ui/shared/ui_helpers.dart';
import 'package:fretto/ui/widgets/box_button.dart';
import 'package:fretto/ui/widgets/box_input_field.dart';
import 'package:fretto/utils/validators.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'signin_view.form.dart';
import 'signin_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'login'),
  FormTextField(name: 'password', isPassword: true),
])
class SigninView extends StatelessWidget with $SigninView {
  SigninView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SigninViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.authenticationSigninText),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: ListView(
                  children: <Widget>[
                    Form(
                        key: model.formKey,
                        child: Column(
                          children: [
                            BoxInputField(
                              controller: loginController,
                              validator: (login) =>
                                  Validators.loginValidator(login),
                              placeholder: AppLocalizations.of(context)!
                                  .signInLoginLabel,
                              leading: Icon(Icons.person),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            verticalSpaceRegular,
                            BoxInputField(
                                controller: passwordController,
                                validator: (password) =>
                                    Validators.passwordValidator(password),
                                placeholder: AppLocalizations.of(context)!
                                    .signInPasswordLabel,
                                leading: Icon(Icons.lock),
                                password: true,
                                textInputAction: TextInputAction.done,
                                focusNode: passwordFocusNode,
                                onFieldSubmitted: (value) => model.signin())
                          ],
                        )),
                    verticalSpaceRegular,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15.0),
                      child: !model.busy(model.signinBusyObj)
                          ? BoxButton(
                              title: AppLocalizations.of(context)!
                                  .authenticationSigninText,
                              onTap: model.signin,
                            )
                          : BoxButton(
                              busy: true,
                              title: AppLocalizations.of(context)!
                                  .authenticationSigninText,
                              onTap: () {}),
                    ),
                    verticalSpaceRegular,
                    RichText(
                      text: TextSpan(
                          text: AppLocalizations.of(context)!
                              .signInForgottenPasswordText,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = model.navigateToPasswordResetRequest),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpaceRegular,
                    RichText(
                      text: TextSpan(
                          text: AppLocalizations.of(context)!
                              .signInNotYetMemeberSignUpText,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = model.navigateToAccountTypeChoice),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ))),
      ),
      viewModelBuilder: () => SigninViewModel(),
    );
  }
}
