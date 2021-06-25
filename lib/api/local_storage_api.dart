import 'package:fretto/app/app.logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageApi {
  final log = getLogger('LocalStorageApi');

  LocalStorageApi._();
  static LocalStorageApi? _instance;
  static SharedPreferences? _preferences;

  static Future<LocalStorageApi> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageApi._();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  dynamic loadFromDisk(String key) {
    var value = _preferences!.get(key);
    log.v('key: $key => value: $value');
    return value;
  }

  Future<bool> saveToDisk<T>(String key, T content) async {
    log.v('Saving key: $key => value: $content');

    if (content is String) {
      return _preferences!.setString(key, content);
    }
    if (content is bool) {
      return _preferences!.setBool(key, content);
    }
    if (content is int) {
      return _preferences!.setInt(key, content);
    }
    if (content is double) {
      return _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      return _preferences!.setStringList(key, content);
    }
    return false;
  }

  Future<bool> removeFromDisk(String key) {
    log.v('key: $key ');
    return _preferences!.remove(key);
  }
}
