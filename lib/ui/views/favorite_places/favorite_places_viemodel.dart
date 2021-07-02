import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.router.dart';
import 'package:fretto/models/geo_place_dto.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FavoritePlacesViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  List<GeoPlaceDto>? _userFavoritePlaces;
  get userFavoritePlaces => _userFavoritePlaces;

  void navigateToCreateFavoritePlace() {
    _navigationService.navigateTo(Routes.createFavoritePlaceView);
  }

  loadUserFavoritePlaces() {}
}
