class ApplicationSettings {
  int userCountryId;
  int userLocaleId;
  int userTimeZoneId;
  String timeZoneName;
  String userLocaleLanguage;
  String userLocaleCountry;

  ApplicationSettings({
    required this.userCountryId,
    required this.userLocaleId,
    required this.userTimeZoneId,
    required this.timeZoneName,
    required this.userLocaleLanguage,
    required this.userLocaleCountry,
  });

  factory ApplicationSettings.fromJson(Map<String, dynamic> json) {
    return ApplicationSettings(
        userCountryId: json['userCountryId'],
        userLocaleId: json['userLocaleId'],
        userTimeZoneId: json['userTimeZoneId'],
        timeZoneName: json['timeZoneName'],
        userLocaleLanguage: json['userLocaleLanguage'],
        userLocaleCountry: json['userLocaleCountry']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = Map<String, dynamic>();
    json['userCountryId'] = this.userCountryId;
    json['userLocaleId'] = this.userLocaleId;
    json['userTimeZoneId'] = this.userTimeZoneId;
    json['timeZoneName'] = this.timeZoneName;
    json['userLocaleLanguage'] = this.userLocaleLanguage;
    json['userLocaleCountry'] = this.userLocaleCountry;

    return json;
  }
}
