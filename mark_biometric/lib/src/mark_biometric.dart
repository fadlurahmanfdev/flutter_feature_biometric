import 'package:mark_platform_interface/mark_platform_interface.dart';

/// Main entry point for biometric and device-credential authentication.
///
/// This class forwards all calls to the active platform implementation.
class MarkBiometric {
  /// Returns `true` when the device has biometric capability.
  ///
  /// This only checks hardware and OS support. It can still return `true`
  /// when no biometric data is enrolled yet.
  Future<bool> isDeviceSupportBiometric() {
    return MarkPlatform.instance.isDeviceSupportBiometric();
  }

  /// Returns the current availability status for [authenticator].
  Future<MarkAuthenticatorStatus> checkAuthenticatorStatus(MarkAuthenticatorType authenticator) {
    return MarkPlatform.instance.checkAuthenticatorStatus(authenticator);
  }

  /// Returns `true` when secure authenticate flow can be used.
  ///
  /// Secure authenticate is required by encrypt/decrypt biometric APIs.
  Future<bool> canSecureAuthenticate() {
    return MarkPlatform.instance.canSecureAuthenticate();
  }

  /// Starts standard authentication using the selected [authenticatorType].
  ///
  /// Callbacks:
  /// - [onSuccessAuthenticate] is called after successful authentication.
  /// - [onFailedAuthenticate] is called when authentication fails.
  /// - [onErrorAuthenticate] is called when an error occurs and includes
  ///   an error `code` and optional `message`.
  /// - [onNegativeButtonClicked] is called when the negative button is tapped
  ///   on supported platforms.
  /// - [onCanceled] is called when the user cancels the prompt.
  ///
  /// Prompt fields such as [title], [subTitle], [negativeText], and
  /// [confirmationRequired] are platform-specific and may be ignored.
  Future<void> authenticate({
    required MarkAuthenticatorType authenticatorType,
    required String title,
    String? subTitle,
    required String description,
    required String negativeText,
    bool confirmationRequired = false,
    required Function() onSuccessAuthenticate,
    Function()? onFailedAuthenticate,
    required Function(String code, String? message) onErrorAuthenticate,
    Function(int which)? onNegativeButtonClicked,
    Function()? onCanceled,
  }) {
    return MarkPlatform.instance.authenticate(
      authenticatorType: authenticatorType,
      title: title,
      subTitle: subTitle,
      description: description,
      negativeText: negativeText,
      confirmationRequired: confirmationRequired,
      onSuccessAuthenticate: onSuccessAuthenticate,
      onFailedAuthenticate: onFailedAuthenticate,
      onErrorAuthenticate: onErrorAuthenticate,
      onNegativeButtonClicked: onNegativeButtonClicked,
      onCanceled: onCanceled,
    );
  }

  /// Returns `true` when enrolled biometric data has changed.
  ///
  /// [key] is the alias used when storing secure biometric data.
  /// [encodedKey] should be the value returned by a previous secure
  /// authenticate flow.
  Future<bool> isBiometricChanged({required String key, required String encodedKey}) {
    return MarkPlatform.instance.isBiometricChanged(alias: key, encodedKey: encodedKey);
  }

  /// Authenticates and encrypts [requestForEncrypt] using secure biometric flow.
  ///
  /// [key] is the secure alias.
  /// [onSuccessAuthenticate] returns platform-specific
  /// [SuccessAuthenticateEncryptState].
  ///
  /// Error and cancellation callbacks behave the same as in [authenticate].
  Future<void> authenticateBiometricSecureEncrypt({
    required String key,
    required Map<String, String> requestForEncrypt,
    required String title,
    String? subTitle,
    required String description,
    required String negativeText,
    bool confirmationRequired = false,
    required Function(SuccessAuthenticateEncryptState state) onSuccessAuthenticate,
    Function()? onFailedAuthenticate,
    required Function(String code, String? message) onErrorAuthenticate,
    Function(int which)? onNegativeButtonClicked,
    Function()? onCanceled,
  }) {
    return MarkPlatform.instance.authenticateSecureEncrypt(
      alias: key,
      requestForEncrypt: requestForEncrypt,
      title: title,
      description: description,
      negativeText: negativeText,
      confirmationRequired: confirmationRequired,
      onSuccessAuthenticate: onSuccessAuthenticate,
      onFailedAuthenticate: onFailedAuthenticate,
      onErrorAuthenticate: onErrorAuthenticate,
      onNegativeButtonClicked: onNegativeButtonClicked,
      onCanceled: onCanceled,
    );
  }

  /// Authenticates and decrypts [requestForDecrypt] using secure biometric flow.
  ///
  /// [key] is the secure alias.
  /// [encodedIVKey] is the key returned by secure encrypt flow
  /// (Android) or encoded domain state (iOS).
  /// [onSuccessAuthenticate] returns platform-specific
  /// [SuccessAuthenticateDecryptState].
  ///
  /// Error and cancellation callbacks behave the same as in [authenticate].
  Future<void> authenticateBiometricSecureDecrypt({
    required String key,
    required String encodedIVKey,
    required Map<String, String> requestForDecrypt,
    required String title,
    String? subTitle,
    required String description,
    required String negativeText,
    bool confirmationRequired = false,
    required Function(SuccessAuthenticateDecryptState state) onSuccessAuthenticate,
    Function()? onFailedAuthenticate,
    required Function(String code, String? message) onErrorAuthenticate,
    Function(int which)? onNegativeButtonClicked,
    Function()? onCanceled,
  }) {
    return MarkPlatform.instance.authenticateSecureDecrypt(
      alias: key,
      encodedKey: encodedIVKey,
      requestForDecrypt: requestForDecrypt,
      title: title,
      description: description,
      negativeText: negativeText,
      confirmationRequired: confirmationRequired,
      onSuccessAuthenticate: onSuccessAuthenticate,
      onFailedAuthenticate: onFailedAuthenticate,
      onErrorAuthenticate: onErrorAuthenticate,
      onNegativeButtonClicked: onNegativeButtonClicked,
      onCanceled: onCanceled,
    );
  }
}
