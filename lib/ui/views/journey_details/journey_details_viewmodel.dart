import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/models/client_journey_request_dto.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class JourneyDetailsViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  void navigateToEditJourneyRequest(ClientJourneyRequestDto journeyRequest) {
    _navigationService.navigateTo(Routes.journeyCreationView,
        arguments:
            JourneyCreationViewArguments(journeyRequest: journeyRequest));
  }
}
