class UserProfileApiException implements Exception {
  final String message;

  UserProfileApiException({
    required this.message,
  });

  @override
  String toString() {
    return 'UserProfileApiException: $message';
  }
}
