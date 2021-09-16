import 'package:fretto/models/discussion.dart';

class DiscussionsResult {
  final int totalElements;
  final int totalPages;
  final int pageNumber;
  final int pageSize;
  final bool hasNext;

  final List<Discussion> discussions;

  DiscussionsResult(
      {required this.totalElements,
      required this.totalPages,
      required this.pageNumber,
      required this.pageSize,
      required this.hasNext,
      required this.discussions});

  factory DiscussionsResult.fromJson(Map<String, dynamic> json) {
    return DiscussionsResult(
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        hasNext: json["hasNext"],
        discussions: ((json["content"]) as List)
            .map<Discussion>((element) => Discussion.fromJson(element))
            .toList());
  }
}
