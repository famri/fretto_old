class DeviceTokenApiException implements Exception {
  final String message;

  DeviceTokenApiException({
    required this.message,
  });

  @override
  String toString() {
    return 'DeviceTokenApiException: $message';
  }
}
