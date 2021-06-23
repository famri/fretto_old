import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';

/// Returns values from the environment read from the .env file
class EnvironmentService {
  static final _log = getLogger('EnvironmentService');
  static EnvironmentService? _instance;
  EnvironmentService._();

  static Future<EnvironmentService> getInstance() async {
    _log.i('Load environment');
    await dotenv.load(fileName: ".env");
    _log.v('Environement loaded');

    if (_instance == null) {
      _instance = EnvironmentService._();
    }
    return _instance!;
  }

  /// Returns the value associated with the key
  String getValue(String key, {bool verbose = false}) {
    final value = dotenv.env[key] ?? NoKey;
    if (verbose) _log.v('key:$key value:$value');
    return value;
  }
}
