import 'package:fretto/api/country_api.dart';
import 'package:fretto/api/user_locale_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/models/user_locale.dart';
import 'package:logger/logger.dart';

class UserLocaleService {
  Logger log = getLogger('UserLocaleService');
  UserLocaleApi _userLocaleApi = locator<UserLocaleApi>();
  List<UserLocale> _userLocales = [];

  get userLocales => _userLocales;

  Future<List<UserLocale>> loadUserLocales() async {
    _userLocales = await _userLocaleApi.fetchUserLocales();
    return _userLocales;
  }
}
