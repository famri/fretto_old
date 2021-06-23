class UserProfileInfo {
  final int gender;
  final bool isTransporter;
  final UserName name;
  final String photoUrl;
  final String dateOfBirth;
  final String minibio;
  final UserEmail email;
  final UserMobile mobile;
  final UserAddress address;

  UserProfileInfo(
      {required this.gender,
      required this.isTransporter,
      required this.name,
      required this.photoUrl,
      required this.dateOfBirth,
      required this.minibio,
      required this.email,
      required this.mobile,
      required this.address});

  factory UserProfileInfo.fromJson(Map<String, dynamic> json) {
    return UserProfileInfo(
        gender: json["gender"],
        isTransporter: json["isTransporter"],
        name: UserName.fromJson(json["name"]),
        photoUrl: json["photoUrl"],
        dateOfBirth: json["dateOfBirth"],
        minibio: json["minibio"],
        email: UserEmail.fromJson(json["email"]),
        mobile: UserMobile.fromJson(json["mobile"]),
        address: UserAddress.fromJson(json["address"]));
  }
}

class UserMobile {
  final int iccId;
  final String value;
  final bool checked;

  UserMobile({required this.iccId, required this.value, required this.checked});

  factory UserMobile.fromJson(Map<String, dynamic> json) {
    return UserMobile(
        iccId: json["iccId"], value: json["value"], checked: json["checked"]);
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

class UserEmail {
  final String value;
  final bool checked;

  UserEmail({required this.value, required this.checked});

  factory UserEmail.fromJson(Map<String, dynamic> json) {
    return UserEmail(value: json["value"], checked: json["checked"]);
  }
}

class UserName {
  final String firstname;
  final String lastname;
  final bool checked;

  UserName(
      {required this.firstname, required this.lastname, required this.checked});

  factory UserName.fromJson(Map<String, dynamic> json) {
    return UserName(
        firstname: json["firstname"],
        lastname: json["lastname"],
        checked: json["checked"]);
  }
}
