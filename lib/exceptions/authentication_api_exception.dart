class AuthenticationApiException implements Exception {
  final String message;
  final int statusCode;
  AuthenticationApiException({required this.message, required this.statusCode});

  @override
  String toString() {
    return 'AuthenticationApiException: message => $message , statusCode: $statusCode';
  }
}
