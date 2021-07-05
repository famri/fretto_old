class UserProfileInfo {
  final GenderInfo gender;
  final NameInfo name;
  final bool isTransporter;
  final String photoUrl;
  final String dateOfBirth;
  final String minibio;
  final EmailInfo email;
  final MobileInfo mobile;
  //final UserAddress address;

  UserProfileInfo({
    required this.gender,
    required this.name,
    required this.isTransporter,
    required this.photoUrl,
    required this.dateOfBirth,
    required this.minibio,
    required this.email,
    required this.mobile,
    //required this.address
  });

  factory UserProfileInfo.fromJson(Map<String, dynamic> json) {
    return UserProfileInfo(
      gender: GenderInfo.fromJson(json["gender"]),
      isTransporter: json["isTransporter"],
      name: NameInfo.fromJson(json["name"]),
      photoUrl: json["photoUrl"],
      dateOfBirth: json["dateOfBirth"],
      minibio: json["miniBio"],
      email: EmailInfo.fromJson(json["email"]),
      mobile: MobileInfo.fromJson(json["mobile"]),
      // address: UserAddress.fromJson(json["address"])
    );
  }
}

class GenderInfo {
  final int id;
  final String value;

  GenderInfo({required this.id, required this.value});

  factory GenderInfo.fromJson(Map<String, dynamic> json) {
    return GenderInfo(id: json["id"], value: json["value"]);
  }
}

class MobileInfo {
  final String value;
  final IccInfo icc;
  final bool checked;

  MobileInfo({required this.icc, required this.value, required this.checked});

  factory MobileInfo.fromJson(Map<String, dynamic> json) {
    return MobileInfo(
        value: json["value"],
        icc: IccInfo.fromJson(json["icc"]),
        checked: json["checked"]);
  }
}

class IccInfo {
  final int id;
  final String value;

  IccInfo({required this.id, required this.value});

  factory IccInfo.fromJson(Map<String, dynamic> json) {
    return IccInfo(id: json["id"], value: json["value"]);
  }
}

class UserAddress {
  final String streetNumber;
  final String streetName;
  final String zipCode;
  final String city;

  UserAddress(
      {required this.streetNumber,
      required this.streetName,
      required this.zipCode,
      required this.city});

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
        streetNumber: json["streetNumber"],
        streetName: json["streetName"],
        zipCode: json["zipCode"],
        city: json["city"]);
  }
}

class EmailInfo {
  final String value;
  final bool checked;

  EmailInfo({required this.value, required this.checked});

  factory EmailInfo.fromJson(Map<String, dynamic> json) {
    return EmailInfo(value: json["value"], checked: json["checked"]);
  }
}

class NameInfo {
  final String firstname;
  final String lastname;
  final ValidationInfo validation;

  NameInfo(
      {required this.firstname,
      required this.lastname,
      required this.validation});

  factory NameInfo.fromJson(Map<String, dynamic> json) {
    return NameInfo(
        firstname: json["firstname"],
        lastname: json["lastname"],
        validation: ValidationInfo.fromJson(json["validationInfo"]));
  }
}

class ValidationInfo {
  final String state;
  final bool isValidated;

  ValidationInfo({required this.state, required this.isValidated});
  factory ValidationInfo.fromJson(Map<String, dynamic> json) {
    return ValidationInfo(
        state: json["state"], isValidated: json["isValidated"]);
  }
}
