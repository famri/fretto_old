import 'package:fretto/models/message.dart';

class DiscussionMessagesResult {
  final int totalElements;
  final int totalPages;
  final int pageNumber;
  final int pageSize;
  final bool hasNext;

  final List<Message> messages;

  DiscussionMessagesResult(
      {required this.totalElements,
      required this.totalPages,
      required this.pageNumber,
      required this.pageSize,
      required this.hasNext,
      required this.messages});

  factory DiscussionMessagesResult.fromJson(Map<String, dynamic> json) {
    return DiscussionMessagesResult(
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        hasNext: json["hasNext"],
        messages: ((json["content"]) as List)
            .map<Message>((element) => Message.fromJson(element))
            .toList());
  }
}
