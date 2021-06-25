import 'dart:convert';

import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/models/application_settings.dart';
import 'package:fretto/models/user_auth_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final log = getLogger('LocalStorageService');

  LocalStorageService._();
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;
  static UserAuthData? _userAuthData;
  static ApplicationSettings? _applicationSettings;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService._();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  UserAuthData? get userAuthData {
    if (_userAuthData != null) return _userAuthData;
    var userAuthDataJson = _loadFromDisk(UserAuthDataKey);

    if (userAuthDataJson == null) return null;
    return UserAuthData.fromJson(json.decode(userAuthDataJson));
  }

  set userAuthData(UserAuthData? userAuthData) {
    _userAuthData = userAuthData;

    if (userAuthData == null) {
      _removeFromDisk(UserAuthDataKey);
      return;
    }

    _saveToDisk(UserAuthDataKey, json.encode(userAuthData.toJson()));
  }

  ApplicationSettings? get applicationSettings {
    if (_applicationSettings != null) return _applicationSettings;
    var applicationSettingsJson = _loadFromDisk(ApplicationSettingsKey);

    if (applicationSettingsJson == null) return null;
    return ApplicationSettings.fromJson(json.decode(applicationSettingsJson));
  }

  set applicationSettings(ApplicationSettings? applicationSettings) {
    _applicationSettings = applicationSettings;

    if (applicationSettings == null) {
      _removeFromDisk(ApplicationSettingsKey);
      return;
    }

    _saveToDisk(
        ApplicationSettingsKey, json.encode(applicationSettings.toJson()));
  }

  dynamic _loadFromDisk(String key) {
    var value = _preferences!.get(key);
    log.v('key: $key => value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    log.v('key: $key => value: $content');

    if (content is String) {
      _preferences!.setString(key, content);
    }
    if (content is bool) {
      _preferences!.setBool(key, content);
    }
    if (content is int) {
      _preferences!.setInt(key, content);
    }
    if (content is double) {
      _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }
  }

  void _removeFromDisk(String key) {
    log.v('key: $key ');
    _preferences!.remove(key);
  }
}
