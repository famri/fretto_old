class ApplicationSettingsException implements Exception {
  final String message;

  ApplicationSettingsException({
    required this.message,
  });

  @override
  String toString() {
    return 'ApplicationSettingsException: $message';
  }
}
