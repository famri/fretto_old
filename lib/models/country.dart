class Country {
  final int id;
  final String name;
  final String code;
  final String flagPath;
  final InternationalCallingCode icc;
  final List<TimeZone> timeZones;

  Country(
      {required this.id,
      required this.name,
      required this.code,
      required this.flagPath,
      required this.icc,
      required this.timeZones});

  factory Country.fromJson(Map<String, dynamic> jsonMap) {
    return Country(
      timeZones: List<TimeZone>.from(
          (jsonMap["timeZones"] as List).map((e) => TimeZone.fromJson(e))),
      id: jsonMap["id"],
      name: jsonMap["name"],
      code: jsonMap["code"],
      flagPath: jsonMap["flagPath"],
      icc: InternationalCallingCode.fromJson(jsonMap["icc"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'flagPath': flagPath,
      'icc': icc.toJson(),
      'timeZones': timeZones.map((e) => e.toJson()).toList()
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
