/// Availability status for a requested authenticator.
enum MarkAuthenticatorStatus {
  /// Authenticator is available and ready to use.
  success,

  /// No matching authenticator hardware exists on this device.
  noHardwareAvailable,

  /// Authenticator exists but is temporarily unavailable.
  unavailable,

  /// Authenticator exists, but the user has not enrolled it yet.
  noneEnrolled,

  /// A required security update is missing.
  securityUpdateRequired,

  /// Current OS version does not support this authenticator flow.
  unsupportedOSVersion,

  /// Any status that is not mapped to a specific value.
  unknown,
}