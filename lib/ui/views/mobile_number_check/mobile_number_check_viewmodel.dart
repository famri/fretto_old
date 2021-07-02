import 'package:stacked/stacked.dart';
import 'mobile_number_check_view.form.dart';

class MobileNumberCheckViewModel extends FormViewModel {
  final UserProfileService _userProfileService = locator<UserProfileService>();

  get formKey => null;

  get icc => null;

  void checkMobile() {}

  initialize() {}

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
