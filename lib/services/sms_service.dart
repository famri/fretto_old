import 'package:fretto/api/sms_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:logger/logger.dart';

class SMSService {
  Logger log = getLogger('SMSService');
  final SMSApi _smsApi = locator<SMSApi>();

  Future<void> sendMobileValidationCode(
      String iccValue,
      String mobileNumberValue,
      String userLocaleLanguage,
      String userLocaleCountry) async {
    _smsApi.sendMobileValidationCode(iccValue, mobileNumberValue,
        userLocaleLanguage + '_' + userLocaleCountry);
  }
}
