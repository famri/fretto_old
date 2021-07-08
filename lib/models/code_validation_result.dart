class CodeValidationResult {
  final bool valid;

  CodeValidationResult({required this.valid});

  factory CodeValidationResult.fromJson(Map<String, dynamic> jsonMap) {
    return CodeValidationResult(
      valid: jsonMap["valid"],
    );
  }
}
