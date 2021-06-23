import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'account_type_choice_viewmodel.dart';

class AccountTypeChoiceView extends StatelessWidget {
 const AccountTypeChoiceView({Key? key}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return ViewModelBuilder<AccountTypeChoiceViewModel>.reactive(
     builder: (context, model, child) => Scaffold(),
     viewModelBuilder: () => AccountTypeChoiceViewModel(),
   );
 }
}