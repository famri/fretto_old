class DiscussionApiException implements Exception {
  final String message;

  DiscussionApiException({
    required this.message,
  });

  @override
  String toString() {
    return 'DiscussionApiException: $message';
  }
}
