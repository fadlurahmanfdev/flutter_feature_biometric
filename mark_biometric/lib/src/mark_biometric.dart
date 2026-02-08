import 'package:mark_platform_interface/mark_platform_interface.dart';

class MarkBiometric {
  /// Returns true if the device is capable of checking biometrics.
  ///
  /// This will return true even if there are no biometrics currently enrolled.
  Future<bool> isDeviceSupportBiometric() {
    return MarkPlatform.instance.isDeviceSupportBiometric();
  }

  /// Check whether biometric status, whether can authenticate or not
  ///
  /// * [MarkAuthenticatorType] - authenticator type (biometric, device credential)
  Future<MarkAuthenticatorStatus> checkAuthenticatorStatus(MarkAuthenticatorType authenticator) {
    return MarkPlatform.instance.checkAuthenticatorStatus(authenticator);
  }

  /// Check if device can secure authenticate
  Future<bool> canSecureAuthenticate() {
    return MarkPlatform.instance.canSecureAuthenticate();
  }

  /// Authenticate Using Biometric
  ///
  /// Parameter:
  /// - [MarkAuthenticatorType] - the authenticator for authentication. (e.g., biometric or device credential)
  /// - [title] - the title will be shown in authentication prompt
  /// - [subTitle] - the subTitle will be shown in authentication prompt
  /// - [description] - the description will be shown in authentication prompt
  /// - [negativeText] - the negative text for button will be shown in authentication prompt
  /// - [confirmationRequired] - If true, confirmation after biometric will be shown before onSuccessAuthenticate() triggered.
  /// - [onSuccessAuthenticate] - This will be triggered if successfully authenticated.
  /// - [onFailedAuthenticate] - This will be triggered if failed authenticated.
  /// - [onErrorAuthenticate] - This will be triggered if authenticate catch an error.
  /// - [onNegativeButtonClicked] - This will be triggered if negative text clicked.
  /// - [onCanceled] - This will be triggered if user cancel through device bottom nav bar.
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

  /// Check whether biometric already changed or enrolled a new biometric
  ///
  /// Parameter:
  /// - [key] - the alias key store for object
  Future<bool> isBiometricChanged({required String key, required String encodedKey}) {
    return MarkPlatform.instance.isBiometricChanged(alias: key, encodedKey: encodedKey);
  }

  /// Authenticate Secure Using Biometric
  ///
  /// Parameter:
  /// - [key] - the alias key to store a key
  /// - [requestForEncrypt] - the data will be encrypted
  /// - [title] - the title will be shown in authentication prompt
  /// - [subTitle] - the subTitle will be shown in authentication prompt
  /// - [description] - the description will be shown in authentication prompt
  /// - [negativeText] - the negative text for button will be shown in authentication prompt
  /// - [confirmationRequired] - If true, confirmation after biometric will be shown before onSuccessAuthenticate() triggered.
  /// - [onSuccessAuthenticate] - This will be triggered if successfully authenticated.
  /// - [onFailedAuthenticate] - This will be triggered if failed authenticated.
  /// - [onErrorAuthenticate] - This will be triggered if authenticate catch an error.
  /// - [onNegativeButtonClicked] - This will be triggered if negative text clicked.
  /// - [onCanceled] - This will be triggered if user cancel through device bottom nav bar.
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

  /// Authenticate Secure Using Biometric
  ///
  /// Parameter:
  /// - [key] - the alias key to store a key
  /// - [encodedIVKey] - the encoded iv key get from secure encrypt authenticate.
  /// - [requestForDecrypt] - the data will be decrypted.
  /// - [title] - the title will be shown in authentication prompt
  /// - [subTitle] - the subTitle will be shown in authentication prompt
  /// - [description] - the description will be shown in authentication prompt
  /// - [negativeText] - the negative text for button will be shown in authentication prompt
  /// - [confirmationRequired] - If true, confirmation after biometric will be shown before onSuccessAuthenticate() triggered.
  /// - [onSuccessAuthenticate] - This will be triggered if successfully authenticated.
  /// - [onFailedAuthenticate] - This will be triggered if failed authenticated.
  /// - [onErrorAuthenticate] - This will be triggered if authenticate catch an error.
  /// - [onNegativeButtonClicked] - This will be triggered if negative text clicked.
  /// - [onCanceled] - This will be triggered if user cancel through device bottom nav bar.
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
