import 'package:fretto/api/geo_place_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/models/geo_place_dto.dart';
import 'package:fretto/models/place_location.dart';
import 'package:logger/logger.dart';

class GeoPlaceService {
  Logger log = getLogger('GeoPlaceService');
  GeoPlaceApi _geoPlaceApi = locator<GeoPlaceApi>();

  Future<List<GeoPlaceDto>?> loadFavoriteGeoPlaces(
      String localeLanguageCode, String localeCountryCode) async {
    return _geoPlaceApi.fetchFavoriteGeoPlaces(
        localeLanguageCode, localeCountryCode);
  }

  Future<GeoPlaceDto> saveFavoriteGeoPlace(
      String placeName,
      PlaceLocation placeLocation,
      String localeLanguageCode,
      String localeCountryCode) async {
    return _geoPlaceApi.saveFavoriteGeoPlace(
        placeName, placeLocation, localeLanguageCode, localeCountryCode);
  }
}
