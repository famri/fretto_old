class EngineTypeApiException implements Exception {
  final String message;

  EngineTypeApiException({
    required this.message,
  });

  @override
  String toString() {
    return 'EngineTypeApiException: $message';
  }
}
