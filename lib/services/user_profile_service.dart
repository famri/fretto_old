import 'package:fretto/api/place_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/models/place_suggestion.dart';
import 'package:logger/logger.dart';

class UserProfileService {
  Logger log = getLogger('UserProfileService');
  UserProfileApi _userProfileApi = locator<UserProfileApi>();

  Future<List<PlaceSuggestion>> loadPlaceSuggestions(
      String query,
      String localeLanguageCode,
      String localeCountryCode,
      String userCountryCode,
      int numberOfResults) async {
    return _placeApi.fetchPlaceSuggestions(query, localeLanguageCode,
        localeCountryCode, userCountryCode, numberOfResults);
  }

  Future<List<PlaceSuggestion>> loadDepartmentSuggestions(
      String query,
      String localeLanguageCode,
      String localeCountryCode,
      String userCountryCode,
      int numberOfResults) async {
    return _placeApi.fetchDepartmentSuggestions(query, localeLanguageCode,
        localeCountryCode, userCountryCode, numberOfResults);
  }
}
