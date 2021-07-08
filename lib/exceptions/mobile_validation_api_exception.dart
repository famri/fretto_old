class MobileValidationApiException implements Exception {
  final String message;

  MobileValidationApiException({
    required this.message,
  });

  @override
  String toString() {
    return 'MobileValidationApiException: $message';
  }
}
