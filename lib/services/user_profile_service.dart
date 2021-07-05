import 'package:fretto/api/user_profile_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/models/user_profile_info.dart';
import 'package:logger/logger.dart';

class UserProfileService {
  Logger log = getLogger('UserProfileService');
  UserProfileApi _userProfileApi = locator<UserProfileApi>();

  Future<UserProfileInfo> loadUserProfileInfo(
      String localeLanguageCode, String localeCountryCode) async {
    UserProfileInfo userProfileInfo = await _userProfileApi
        .fetchUserProfileInfo(localeLanguageCode + '_' + localeCountryCode);
    return userProfileInfo;
  }

  Future<void> updateMobileInfo(int iccId, String mobileNumberValue) async {
    await _userProfileApi.updateMobileInfo(iccId, mobileNumberValue);
  }
}
