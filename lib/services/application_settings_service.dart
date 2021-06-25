import 'dart:convert';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/models/application_settings.dart';

import '../api/local_storage_api.dart';

class ApplicationSettingsService {
  final log = getLogger('ApplicationSettingsService');
  final LocalStorageApi _localStorageApi = locator<LocalStorageApi>();

  ApplicationSettings? _applicationSettings;

  ApplicationSettings? get applicationSettings {
    if (_applicationSettings != null) {
      return _applicationSettings;
    }

    var applicationSettings =
        _localStorageApi.loadFromDisk(ApplicationSettingsKey);

    if (applicationSettings == null) {
      return null;
    }
    _applicationSettings =
        ApplicationSettings.fromJson(json.decode(applicationSettings));
    return _applicationSettings;
  }

  Future<bool> updateApplicationSettings(
      ApplicationSettings? applicationSettings) async {
    _applicationSettings = applicationSettings;
    return _updateStoredApplicationSettings(applicationSettings);
  }

  Future<bool> _updateStoredApplicationSettings(
      ApplicationSettings? applicationSettings) async {
    if (applicationSettings == null) {
      bool isRemovedSuccessfully =
          await _localStorageApi.removeFromDisk(ApplicationSettingsKey);
      if (!isRemovedSuccessfully) {
        log.e('Unable to remove old application settings data.');
      }
      return isRemovedSuccessfully;
    }

    bool isSavedSuccessfully = await _localStorageApi.saveToDisk(
        ApplicationSettingsKey, json.encode(applicationSettings.toJson()));

    if (!isSavedSuccessfully) {
      log.e('Unable to save new application settings data.');
    }

    return isSavedSuccessfully;
  }
}
