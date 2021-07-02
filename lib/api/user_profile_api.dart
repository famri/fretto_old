import 'dart:convert';
import 'dart:io';

import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/constants/app_keys.dart';
import 'package:fretto/exceptions/place_api_exception.dart';
import 'package:fretto/models/place_suggestion.dart';
import 'package:fretto/models/user_profile_info.dart';
import 'package:fretto/services/authentication_service.dart';
import 'package:fretto/services/environment_service.dart';
import 'package:http/http.dart' as http;

class UserProfileApi {
  final log = getLogger('UserProfileApi');
  final EnvironmentService _environmentService = locator<EnvironmentService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<UserProfileInfo> fetchUserProfileInfo() async {
    return UserProfileInfo.fromJson({
      "gender": 1,
      "name": {"firstname": "Foued", "lastname": "AMRI", "checked": false},
      "isTransporter": true,
      "photoUrl":
          "https://png.pngtree.com/png-clipart/20190904/original/pngtree-user-cartoon-avatar-pattern-flat-avatar-png-image_4492883.jpg",
      "dateOfBirth": "17/10/1988",
      "minibio": "Je suis ingénieur en informatique avec 10 ans d'expérience.",
      "email": {"value": "amri.foued@gmail.com", "checked": false},
      "mobile": {"value": "96111222", "iccId": 1, "checked": false},
      "address": {
        "streetNumber": "859",
        "streetName": "Route de Gabès Km9, cité Thyna 2",
        "zipCode": "3083",
        "city": "Sfax"
      }
    });
  }
}
