/// Base type for secure decrypt authentication success states.
abstract class SuccessAuthenticateDecryptState {}

/// Android result returned after secure decrypt authentication.
class SuccessAuthenticateDecryptAndroid extends SuccessAuthenticateDecryptState {
  /// Map of decrypted values keyed by the original request keys.
  Map<String, String?> decryptedResult;

  /// Creates an Android secure decrypt success state.
  SuccessAuthenticateDecryptAndroid({
    required this.decryptedResult,
  });
}

/// iOS result returned after secure decrypt authentication.
class SuccessAuthenticateDecryptIOS extends SuccessAuthenticateDecryptState {}