class MobileValidationException implements Exception {
  final String message;
  MobileValidationException(this.message);
  @override
  String toString() {
    return message;
  }
}
