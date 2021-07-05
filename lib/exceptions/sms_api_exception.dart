class SMSApiException implements Exception {
  final String message;

  SMSApiException({
    required this.message,
  });

  @override
  String toString() {
    return 'SMSApiException: $message';
  }
}
