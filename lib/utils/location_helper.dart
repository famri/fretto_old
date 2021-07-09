import 'dart:convert';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:http/http.dart' as http;

class LocationHelper {
  static EnvironmentService _environmentService = locator<EnvironmentService>();

  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7C%7C$latitude,$longitude&key=${_environmentService.getValue(GoogleMapsEnvKey)}';
  }

  static Future<String> getPlaceAddress(
      double latitude, double longitude) async {
    Map<String, String> queryParams = {
      'latlng': '$latitude,$longitude',
      'key': _environmentService.getValue(GoogleMapsEnvKey)
    };
    final Uri placeAddressUri = Uri.https(
        'https://maps.googleapis.com', '/maps/api/geocode/json', queryParams);
    final response = await http.get(placeAddressUri);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
