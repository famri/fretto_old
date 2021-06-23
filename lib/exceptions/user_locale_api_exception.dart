class UserLocaleApiException implements Exception {
  final String message;

  UserLocaleApiException({
    required this.message,
  });

  @override
  String toString() {
    return 'UserLocaleApiException: $message';
  }
}
