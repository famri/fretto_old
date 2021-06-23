class ReadMessage {
  final int id;
  final int authorId;
  final String content;
  final DateTime dateTime;
  final bool isRead;
  final bool isSent;

  ReadMessage(
      {required this.id,
      required this.authorId,
      required this.content,
      required this.dateTime,
      required this.isRead,
      required this.isSent});

  factory ReadMessage.fromJson(Map<String, dynamic> json) {
    return ReadMessage(
      id: json["id"],
      authorId: json["authorId"],
      content: json["content"],
      dateTime: DateTime.parse(json["dateTime"]),
      isRead: json["read"],
      isSent: true,
    );
  }
}
