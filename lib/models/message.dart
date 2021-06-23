class Message {
  final int id;
  final int authorId;
  final String content;
  final DateTime dateTime;
  bool isRead;
  bool isSent;

  Message(
      {required this.id,
      required this.authorId,
      required this.content,
      required this.dateTime,
      required this.isRead,
      required this.isSent});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["id"],
      authorId: json["authorId"],
      content: json["content"],
      dateTime: DateTime.parse(json["dateTime"]),
      isRead: json["read"],
      isSent: true,
    );
  }
}
