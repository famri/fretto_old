class UserLocale {
  final int id;
  final String name;
  final String languageCode;
  final String countryCode;

  UserLocale(
      {required this.id,
      required this.name,
      required this.languageCode,
      required this.countryCode});

  factory UserLocale.fromJson(Map<String, dynamic> json) {
    return UserLocale(
        id: json["id"],
        name: json["name"],
        languageCode: json["languageCode"],
        countryCode: json["countryCode"]);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'languageCode': languageCode,
        'countryCode': countryCode
      };

  @override
  String toString() {
    return languageCode + '_' + countryCode;
  }
}
