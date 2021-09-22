class MessagingApiException implements Exception {
  final String message;

  MessagingApiException({
    required this.message,
  });

  @override
  String toString() {
    return 'MessagingApiException: $message';
  }
}
