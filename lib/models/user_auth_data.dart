class UserAuthData {
  String? token;
  String? refreshToken;
  DateTime? expiryDate;
  String? username;
  List<String>? authorities;

  UserAuthData(
      {required this.token,
      required this.refreshToken,
      required this.expiryDate,
      required this.username,
      required this.authorities});

  factory UserAuthData.fromJson(Map<String, dynamic> json) {
    return new UserAuthData(
        token: json['token'],
        refreshToken: json['refreshToken'],
        expiryDate: DateTime.parse(json['expiryDate'].toString()),
        username: json['username'],
        authorities: (json['authorities'] as List<dynamic>).cast<String>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = Map<String, dynamic>();
    json['token'] = this.token;
    json['refreshToken'] = this.refreshToken;
    json['expiryDate'] = this.expiryDate!.toIso8601String();
    json['username'] = this.username;
    json['authorities'] = this.authorities;

    return json;
  }

  bool get isAuthenticated =>
      this.expiryDate != null && DateTime.now().isBefore(this.expiryDate!);
  bool get isClient =>
      this.authorities != null && authorities!.contains('ROLE_CLIENT');
}
