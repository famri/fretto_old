class JourneyRequestApiException implements Exception {
  final String message;
  final int statusCode;

  JourneyRequestApiException({required this.message, required this.statusCode});

  @override
  String toString() {
    return 'JourneyRequestApiException: $message';
  }
}
