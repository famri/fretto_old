import 'package:fretto/models/place_location.dart';
import 'package:stacked/stacked.dart';

class CreateFavoritePlaceViewModel extends FormViewModel {
  PlaceLocation? _placeLocation;
  void updatePlaceLocation(PlaceLocation placeLocation) {
    _placeLocation = placeLocation;
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  void savePlace() {}
}
