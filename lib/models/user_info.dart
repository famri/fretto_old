class UserInfo {
  final int id;
  final String username;
  final List<String> authorities;

  UserInfo(
      {required this.id, required this.username, required this.authorities});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        id: json["id"],
        username: json["username"],
        authorities: json["authorities"]);
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'username': this.username,
        'authorities': this.authorities
      };
}
