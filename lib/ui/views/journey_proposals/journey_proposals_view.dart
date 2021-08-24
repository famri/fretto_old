import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'journey_proposals_viewmodel.dart';

class JourneyProposalsView extends StatelessWidget {
  final int journeyId;

  const JourneyProposalsView({Key? key, required this.journeyId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JourneyProposalsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(),
      viewModelBuilder: () => JourneyProposalsViewModel(),
    );
  }
}
