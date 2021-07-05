import 'package:fretto/api/country_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/models/country.dart';
import 'package:logger/logger.dart';

class CountryService {
  Logger log = getLogger('CountryService');
  CountryApi _countryApi = locator<CountryApi>();
  List<Country>? _countries;
  Map<int, IccInfoDto>? _internationaCallingCodes;

  Future<List<Country>?> loadCountries(
      String localeLanguageCode, String localeCountryCode) async {
    if (_countries == null) {
      _countries = await _countryApi.fetchCountries(
          localeLanguageCode, localeCountryCode);
    }
    return _countries;
  }

  Future<Map<int, IccInfoDto>?> loadInternationalCallingCodes(
      String localeLanguageCode, String localeCountryCode) async {
    if (_internationaCallingCodes == null) {
      if (_countries == null) {
        _countries = await _countryApi.fetchCountries(
            localeLanguageCode, localeCountryCode);
      }
      _internationaCallingCodes = {};
      _countries!.forEach((country) =>
          _internationaCallingCodes![country.icc.id] = IccInfoDto(
              name: "${country.name} (${country.icc.value})",
              value: country.icc.value));
    }

    return _internationaCallingCodes;
  }
}

class IccInfoDto {
  final String name;
  final String value;

  IccInfoDto({required this.name, required this.value});
}
