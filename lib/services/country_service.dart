import 'package:fretto/api/country_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/models/country.dart';

class CountryService {
  CountryApi _countryApi = locator<CountryApi>();
  List<Country>? _countries;

  get countries => _countries;

  Future<List<Country>?> loadCountries(
      String localeLanguageCode, String localeCountryCode) async {
    _countries =
        await _countryApi.fetchCountries(localeLanguageCode, localeCountryCode);
    return _countries;
  }

  String? getCountryInternationalCallingCode(int countryId) {
    if (_countries != null) {
      return _countries!
          .firstWhere((element) => element.id == countryId)
          .icc
          .value;
    } else {
      return null;
    }
  }
}
