import 'package:fretto/api/country_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/models/country.dart';
import 'package:logger/logger.dart';

class CountryService {
  Logger log = getLogger('CountryService');
  CountryApi _countryApi = locator<CountryApi>();
  List<Country>? _countries;

  get countries => _countries;

  Future<List<Country>?> loadCountries(
      String localeLanguageCode, String localeCountryCode) async {
    if (_countries == null) {
      _countries = await _countryApi.fetchCountries(
          localeLanguageCode, localeCountryCode);
    }
    return _countries;
  }
}
