class PlaceApiException implements Exception {
  final String message;

  PlaceApiException({
    required this.message,
  });

  @override
  String toString() {
    return 'PlaceApiException: $message';
  }
}
