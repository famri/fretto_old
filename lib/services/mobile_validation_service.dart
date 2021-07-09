import 'package:fretto/api/mobile_validation_api.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/app/app.logger.dart';
import 'package:fretto/models/code_validation_result.dart';
import 'package:logger/logger.dart';

class MobileValidationService {
  Logger log = getLogger('MobileValidationService');
  final MobileValidationApi _mobileValidationApi = locator<MobileValidationApi>();

  Future<void> sendMobileValidationCode(
      String iccValue,
      String mobileNumberValue,
      String userLocaleLanguage,
      String userLocaleCountry) async {
    await _mobileValidationApi.sendMobileValidationCode(iccValue, mobileNumberValue,
        userLocaleLanguage + '_' + userLocaleCountry);
  }

  Future<bool> validateMobileValidationCode(String smsCodeValue) async {
    CodeValidationResult codeValidationResult =
        await _mobileValidationApi.validateMobileValidationCode(smsCodeValue);

    return codeValidationResult.valid;
  }
}
