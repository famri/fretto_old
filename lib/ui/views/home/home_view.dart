import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/ui/views/discussions/discussions_view.dart';
import 'package:fretto/ui/views/journey_creation/journey_creation_view.dart';
import 'package:fretto/ui/views/journey_requests/journey_requests_view.dart';
import 'package:fretto/ui/views/profile/profile_view.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  final int? viewIndex;

  HomeView({Key? key, this.viewIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => _initialize(model),
      builder: (context, viewModel, child) => Scaffold(
        body: PageTransitionSwitcher(
            duration: const Duration(milliseconds: 500),
            reverse: viewModel.reverse,
            transitionBuilder: (Widget child,
                Animation<double> primaryAnimation,
                Animation<double> secondaryAnimation) {
              return SharedAxisTransition(
                child: child,
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
              );
            },
            child: getViewForIndex(viewModel.currentIndex)),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: viewModel.currentIndex,
          onTap: viewModel.setIndex,
          items: [
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.homeDemandText,
              icon: Icon(
                Icons.airport_shuttle,
                //color: Colors.amber,
              ),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.homeJourneysText,
              icon: Icon(
                Icons.list,
                // color: Colors.amber
              ),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.homeDiscussionsText,
              icon: Icon(
                Icons.message,
                // color: Colors.amber
              ),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.homeProfileText,
              icon: Icon(
                Icons.person,
                // color: Colors.amber
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return JourneyCreationView();
      case 1:
        return JourneyRequestsView();
      case 2:
        return DiscussionsView();
      case 3:
        return ProfileView();
      default:
        return JourneyCreationView();
    }
  }

  _initialize(HomeViewModel model) {
    if (viewIndex != null) {
      model.setIndex(viewIndex!);
    }
  }
}
