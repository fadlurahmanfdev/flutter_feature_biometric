// ignore_for_file: constant_identifier_names

/// iOS-specific fallback error codes returned by Dart wrapper.
class ErrorConstantIOS {
  ErrorConstantIOS._();

  /// Returned when an unsupported policy is requested.
  static const IOS_UNKNOWN_POLICY = 'IOS_UNKNOWN_POLICY';

  /// Returned when native result status is not mapped.
  static const IOS_UNKNOWN_RESULT = 'IOS_UNKNOWN_RESULT';

  /// Returned when authentication fails with an unexpected exception.
  static const IOS_UNKNOWN_UNABLE_AUTHENTICATE = 'IOS_UNKNOWN_UNABLE_AUTHENTICATE';
}