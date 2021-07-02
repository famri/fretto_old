import 'package:fretto/api/engine_type_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/models/engine_type.dart';
import 'package:logger/logger.dart';

class EngineTypeService {
  Logger log = getLogger('EngineTypeService');
  EngineTypeApi _engineTypeApi = locator<EngineTypeApi>();
  List<EngineType>? _engineTypes;

  get engineTypes => _engineTypes;

  Future<List<EngineType>?> loadEngineTypes(
      String localeLanguageCode, String localeCountryCode) async {
    if (_engineTypes != null) return _engineTypes;
    return _engineTypes = await _engineTypeApi.fetchEngineTypes(
        localeLanguageCode, localeCountryCode);
  }
}
