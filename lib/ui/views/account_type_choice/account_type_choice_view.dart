import 'package:flutter/material.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/ui/shared/ui_helpers.dart';
import 'package:fretto/ui/widgets/box_button.dart';
import 'package:stacked/stacked.dart';

import 'account_type_choice_viewmodel.dart';

class AccountTypeChoiceView extends StatelessWidget {
  const AccountTypeChoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountTypeChoiceViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.chooseUserTypeAppBarText),
            actions: [],
          ),
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.chooseUserTypeHeaderText,
                  style: Theme.of(context).textTheme.headline1,
                ),
                verticalSpaceMedium,
                Row(children: [
                  Expanded(
                      child: Text(
                    AppLocalizations.of(context)!
                        .chooseUserTypeTransporterLabel,
                    style: Theme.of(context).textTheme.headline2,
                  )),
                  GestureDetector(
                    child: Container(
                      height: 150,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: AssetImage('assets/images/driver.png'),
                        ),
                        borderRadius: new BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                        border: Border.all(
                            width: model.isTransporter == null ||
                                    !model.isTransporter!
                                ? 1.0
                                : 3.0,
                            color: model.isTransporter == null ||
                                    !model.isTransporter!
                                ? Colors.grey
                                : Colors.greenAccent),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    onTap: () => model.updateIsTransporter(true),
                  )
                ]),
                verticalSpaceMedium,
                Divider(
                  thickness: 1.5,
                  indent: 15.0,
                  endIndent: 15.0,
                ),
                verticalSpaceMedium,
                Row(children: [
                  Expanded(
                      child: Text(
                    AppLocalizations.of(context)!.chooseUserTypeCustomerLabel,
                    style: Theme.of(context).textTheme.headline2,
                  )),
                  GestureDetector(
                    child: Container(
                      height: 150,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: AssetImage('assets/images/customer.png'),
                        ),
                        borderRadius: new BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                        border: Border.all(
                            width: model.isTransporter == null ||
                                    model.isTransporter!
                                ? 1.0
                                : 3.0,
                            color: model.isTransporter == null ||
                                    model.isTransporter!
                                ? Colors.grey
                                : Colors.greenAccent),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    onTap: () => model.updateIsTransporter(false),
                  )
                ]),
                verticalSpaceMedium,
                if (model.hasError) model.error(model),
                verticalSpaceMedium,
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: BoxButton(
                    title: AppLocalizations.of(context)!.nextButtonText,
                    onTap: () => model.navigateToSignup(context),
                  ),
                ),
              ],
            ),
          )))),
      viewModelBuilder: () => AccountTypeChoiceViewModel(),
    );
  }
}
