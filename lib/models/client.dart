class Client {
  final int id;
  final String firstname;
  final String photoUrl;
  Client({required this.id, required this.firstname,required  this.photoUrl});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
        id: json["id"],
        firstname: json["firstname"],
        photoUrl: json["photoUrl"]);
  }
}
