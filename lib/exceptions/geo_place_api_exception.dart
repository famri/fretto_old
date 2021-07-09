class GeoPlaceApiException implements Exception {
  final String message;

  GeoPlaceApiException({
    required this.message,
  });

  @override
  String toString() {
    return 'GeoPlaceApiException: $message';
  }
}
