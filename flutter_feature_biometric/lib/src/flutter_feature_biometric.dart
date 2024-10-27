import 'dart:io';
import 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';

class FlutterFeatureBiometric {
  Future<bool> isDeviceSupportBiometric() {
    return FlutterFeatureBiometricPlatform.instance.isDeviceSupportBiometric();
  }

  Future<BiometricStatus> checkAuthenticatorStatus(BiometricAuthenticatorType authenticator) {
    return FlutterFeatureBiometricPlatform.instance.checkAuthenticationTypeStatus(authenticator);
  }

  Future<bool> canSecureAuthenticate() {
    return FlutterFeatureBiometricPlatform.instance.canSecureAuthenticate();
  }

  Future<void> authenticate({
    required BiometricAuthenticatorType authenticator,
    required String title,
    required String description,
    required String negativeText,
    required Function() onSuccessAuthenticate,
    Function()? onFailed,
    Function(String code, String? message)? onError,
    Function(int which)? onDialogClicked,
    Function()? onCanceled,
  }) {
    return FlutterFeatureBiometricPlatform.instance.authenticate(
      authenticator: authenticator,
      title: title,
      description: description,
      negativeText: negativeText,
      onSuccessAuthenticate: onSuccessAuthenticate,
      onFailed: onFailed,
      onError: onError,
      onDialogClicked: onDialogClicked,
      onCanceled: onCanceled,
    );
  }

  Future<void> secureEncryptAuthenticate({
    required String key,
    required Map<String, String> requestForEncrypt,
    required String title,
    required String description,
    required String negativeText,
    required Function(SuccessAuthenticateEncryptState state) onSuccessAuthenticate,
    Function()? onFailed,
    Function(String code, String? message)? onError,
    Function(int which)? onDialogClicked,
    Function()? onCanceled,
  }) {
    return FlutterFeatureBiometricPlatform.instance.secureEncryptAuthenticate(
      key: key,
      requestForEncrypt: requestForEncrypt,
      title: title,
      description: description,
      negativeText: negativeText,
      onSuccessAuthenticate: onSuccessAuthenticate,
      onFailed: onFailed,
      onError: onError,
      onDialogClicked: onDialogClicked,
      onCanceled: onCanceled,
    );
  }

  Future<void> secureDecryptAuthenticate({
    required String key,
    required String encodedIVKey,
    required Map<String, String> requestForDecrypt,
    required String title,
    required String description,
    required String negativeText,
    required Function(SuccessAuthenticateDecryptState state) onSuccessAuthenticate,
    Function()? onFailed,
    Function(String code, String? message)? onError,
    Function(int which)? onDialogClicked,
  }) {
    return FlutterFeatureBiometricPlatform.instance.secureDecryptAuthenticate(
      key: key,
      encodedIVKey: encodedIVKey,
      requestForDecrypt: requestForDecrypt,
      title: title,
      description: description,
      negativeText: negativeText,
      onSuccessAuthenticate: onSuccessAuthenticate,
      onFailed: onFailed,
      onError: onError,
      onDialogClicked: onDialogClicked,
    );
  }
}
