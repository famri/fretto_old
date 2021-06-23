import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'signin_viewmodel.dart';

class SigninView extends StatelessWidget {
  const SigninView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SigninViewModel>.reactive(
      builder: (context, model, child) => Scaffold(),
      viewModelBuilder: () => SigninViewModel(),
    );
  }
}
