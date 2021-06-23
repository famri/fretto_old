class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({
    required this.message,
  });

  @override
  String toString() {
    return 'AuthenticationException: $message';
  }
}
