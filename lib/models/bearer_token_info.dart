class BearerTokenInfo {
  final String token;
  final String refreshToken;
  final DateTime expiryDate;

  BearerTokenInfo(
      {required this.token,
      required this.refreshToken,
      required this.expiryDate});

  factory BearerTokenInfo.fromJson(Map<String, dynamic> jsonMap) {
    return BearerTokenInfo(
      token: jsonMap['token'],
      refreshToken: jsonMap['refreshToken'],
      expiryDate: jsonMap['expiryDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'expiryDate': expiryDate,
    };
  }
}

class InternationalCallingCode {
  final int id;
  final String value;

  InternationalCallingCode({required this.id, required this.value});
  factory InternationalCallingCode.fromJson(Map<String, dynamic> json) {
    return InternationalCallingCode(id: json["id"], value: json["value"]);
  }
  Map<String, dynamic> toJson() => {'id': id, 'value': value};
}

class TimeZone {
  final int id;
  final String name;
  final String gmtOffset;

  TimeZone({required this.id, required this.name, required this.gmtOffset});

  factory TimeZone.fromJson(Map<String, dynamic> json) {
    return TimeZone(
        id: json["id"], name: json["name"], gmtOffset: json["gmtOffset"]);
  }
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'gmtOffset': gmtOffset};
}
