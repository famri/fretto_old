import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'discussions_viemodel.dart';

class DiscussionsView extends StatelessWidget {
  const DiscussionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiscussionsViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => Scaffold(),
      viewModelBuilder: () => DiscussionsViewModel(),
    );
  }
}
