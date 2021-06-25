import 'package:flutter/material.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/ui/shared/colors.dart';
import 'package:fretto/ui/shared/styles.dart';
import 'package:fretto/ui/shared/ui_helpers.dart';
import 'package:fretto/ui/views/authentication_choice/authentication_choice_viewmodel.dart';
import 'package:fretto/ui/widgets/box_button.dart';
import 'package:stacked/stacked.dart';

class AuthenticationChoiceView extends StatelessWidget {
  const AuthenticationChoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationChoiceViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
              Stack(children: [
                Container(
                  height: screenHeightPercentage(context, percentage: 0.5),
                  child: Image.asset('assets/images/home_background.png',
                      fit: BoxFit.cover),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 0),
                  height: screenHeightPercentage(context, percentage: 0.2),
                  child: Image.asset('assets/images/fretto_logo.png',
                      fit: BoxFit.scaleDown),
                ),
              ]),
              Container(
                  height: screenHeightPercentage(context, percentage: 0.3),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
                  child: Text(
                    AppLocalizations.of(context)!.authenticationMotto,
                    softWrap: true,
                    style: heading1Style.copyWith(color: kcPetroliumBlue),
                    textAlign: TextAlign.center,
                  )),
              Container(
                  height: screenHeightPercentage(context, percentage: 0.2),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 0),
                            child: BoxButton(
                              title: AppLocalizations.of(context)!
                                  .authenticationSignupText,
                              onTap: model.navigateToAccountTypeChoice,
                            )),
                        verticalSpaceSmall,
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 0),
                            child: BoxButton(
                              title: AppLocalizations.of(context)!
                                  .authenticationSigninText,
                              onTap: model.navigateToSignIn,
                            )),
                      ])),
            ])),
      ),
      viewModelBuilder: () => AuthenticationChoiceViewModel(),
    );
  }
}
