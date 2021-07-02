import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:stacked/stacked.dart';

import 'journey_requests_viewmodel.dart';

class JourneyRequestsView extends StatelessWidget {
  const JourneyRequestsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JourneyRequestsViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) =>
          Scaffold(body: Center(child: Text('My Journey requests'))),
      viewModelBuilder: () => locator<JourneyRequestsViewModel>(),
    );
  }
}
