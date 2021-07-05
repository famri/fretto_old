class ApplicationSettings {
  int userCountryId;
  int userLocaleId;
  int userTimeZoneId;
  String timeZoneName;
  String userLocaleLanguage;
  String userLocaleCountry;
  String userCountryIcc;
  int userCountryIccId;
  String userCountryCode;

  ApplicationSettings(
      {required this.userCountryId,
      required this.userLocaleId,
      required this.userTimeZoneId,
      required this.timeZoneName,
      required this.userLocaleLanguage,
      required this.userLocaleCountry,
      required this.userCountryIcc,
      required this.userCountryIccId,
      required this.userCountryCode});

  factory ApplicationSettings.fromJson(Map<String, dynamic> json) {
    return ApplicationSettings(
        userCountryId: json['userCountryId'],
        userLocaleId: json['userLocaleId'],
        userTimeZoneId: json['userTimeZoneId'],
        timeZoneName: json['timeZoneName'],
        userLocaleLanguage: json['userLocaleLanguage'],
        userLocaleCountry: json['userLocaleCountry'],
        userCountryIcc: json['userCountryIcc'],
        userCountryIccId: json['userCountryIccId'],
        userCountryCode: json['userCountryCode']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = Map<String, dynamic>();
    json['userCountryId'] = this.userCountryId;
    json['userLocaleId'] = this.userLocaleId;
    json['userTimeZoneId'] = this.userTimeZoneId;
    json['timeZoneName'] = this.timeZoneName;
    json['userLocaleLanguage'] = this.userLocaleLanguage;
    json['userLocaleCountry'] = this.userLocaleCountry;
    json['userCountryIcc'] = this.userCountryIcc;
    json['userCountryIccId'] = this.userCountryIccId;
    json['userCountryCode'] = this.userCountryCode;
    return json;
  }
}
