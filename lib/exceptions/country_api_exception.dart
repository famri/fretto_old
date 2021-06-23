class CountryApiException implements Exception {
  final String message;

  CountryApiException({
    required this.message,
  });

  @override
  String toString() {
    return 'CountryApiException: $message';
  }
}
