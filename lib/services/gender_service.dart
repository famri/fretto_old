import 'package:fretto/api/gender_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/models/gender.dart';

class GenderService {
  GenderApi _genderApi = locator<GenderApi>();
  List<Gender>? _genders;

  get genders => _genders;

  Future<List<Gender>?> loadCountries(
      String localeLanguageCode, String localeCountryCode) async {
    _genders =
        await _genderApi.fetchGenders(localeLanguageCode, localeCountryCode);
    return _genders;
  }
}
