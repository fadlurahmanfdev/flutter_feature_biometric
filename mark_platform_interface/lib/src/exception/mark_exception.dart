/// Exception used by platform implementations to pass error details.
class FeatureBiometricException {
  /// Machine-readable error code.
  String code;

  /// Human-readable error message when available.
  String? message;

  /// Creates a [FeatureBiometricException].
  FeatureBiometricException({
    required this.code,
    this.message,
  });
}
