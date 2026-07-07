/// Base type for secure encrypt authentication success states.
abstract class SuccessAuthenticateEncryptState {}

/// Android result returned after secure encrypt authentication.
class SuccessAuthenticateEncryptAndroid extends SuccessAuthenticateEncryptState {
  /// Encoded IV key required for secure decrypt authentication.
  String encodedIVKey;

  /// Map of encrypted values keyed by the original request keys.
  Map<String, String?> encryptedResult;

  /// Creates an Android secure encrypt success state.
  SuccessAuthenticateEncryptAndroid({
    required this.encodedIVKey,
    required this.encryptedResult,
  });
}

/// iOS result returned after secure encrypt authentication.
class SuccessAuthenticateEncryptIOS extends SuccessAuthenticateEncryptState {
  /// Encoded domain state used to detect biometric changes.
  String encodedDomainState;

  /// Creates an iOS secure encrypt success state.
  SuccessAuthenticateEncryptIOS({required this.encodedDomainState});
}