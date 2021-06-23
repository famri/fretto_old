class AuthenticationApiException implements Exception {
  final String message;

  AuthenticationApiException({
    required this.message,
  });

  @override
  String toString() {
    return 'AuthenticationApiException: $message';
  }
}
