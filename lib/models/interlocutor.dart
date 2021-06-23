class Interlocutor {
  final int id;
  final String name;
  final String mobileNumber;
  final String photoUrl;

  Interlocutor({required this.id, required this.name, required this.mobileNumber,required  this.photoUrl});

  factory Interlocutor.fromJson(Map<String, dynamic> json) {
    return Interlocutor(
      id: json["id"],
      name: json["name"],
      mobileNumber: json["mobileNumber"],
      photoUrl: json["photoUrl"],
    );
  }
}
