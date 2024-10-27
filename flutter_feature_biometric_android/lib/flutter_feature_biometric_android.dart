// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter_feature_biometric_android/src/messages.g.dart';
import 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';
export 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';

/// The implementation of [FlutterFeatureBiometricPlatform] for Android.
class FlutterFeatureBiometricAndroid extends FlutterFeatureBiometricPlatform {
  /// Creates a new plugin implementation instance.
  FlutterFeatureBiometricAndroid({
    @visibleForTesting FlutterFeatureBiometricApi? api,
  }) : _api = api ?? FlutterFeatureBiometricApi();

  /// Registers this class as the default instance of [FlutterFeatureBiometricPlatform].
  static void registerWith() {
    FlutterFeatureBiometricPlatform.instance = FlutterFeatureBiometricAndroid();
  }

  final FlutterFeatureBiometricApi _api;

  @override
  Future<bool> isDeviceSupportBiometric() async {
    return _api.isDeviceSupportBiometric();
  }

  @override
  Future<BiometricStatus> checkAuthenticationTypeStatus(BiometricAuthenticatorType authenticator) async {
    NativeBiometricStatus nativeStatus;
    switch (authenticator) {
      case BiometricAuthenticatorType.biometric:
        nativeStatus = await _api.checkAuthenticationStatus(NativeBiometricAuthenticator.weak);
      case BiometricAuthenticatorType.deviceCredential:
        nativeStatus = await _api.checkAuthenticationStatus(NativeBiometricAuthenticator.deviceCredential);
    }
    switch (nativeStatus) {
      case NativeBiometricStatus.success:
        return BiometricStatus.success;
      case NativeBiometricStatus.noAvailable:
        return BiometricStatus.noAvailable;
      case NativeBiometricStatus.unavailable:
        return BiometricStatus.unavailable;
      case NativeBiometricStatus.noneEnrolled:
        return BiometricStatus.noneEnrolled;
      case NativeBiometricStatus.unknown:
        return BiometricStatus.unknown;
    }
  }

  @override
  Future<bool> canSecureAuthenticate() async {
    return (await _api.checkAuthenticationStatus(NativeBiometricAuthenticator.strong)) == NativeBiometricStatus.success;
  }

  @override
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
  }) async {
    NativeBiometricAuthenticator nativeAuthenticator;
    switch (authenticator) {
      case BiometricAuthenticatorType.biometric:
        nativeAuthenticator = NativeBiometricAuthenticator.weak;
      case BiometricAuthenticatorType.deviceCredential:
        nativeAuthenticator = NativeBiometricAuthenticator.deviceCredential;
    }

    final result = await _api.authenticate(
      authenticator: nativeAuthenticator,
      title: title,
      description: description,
      negativeText: negativeText,
    );
    switch (result.status) {
      case NativeAuthResultStatus.success:
        onSuccessAuthenticate();
        break;
      case NativeAuthResultStatus.failed:
        if (onFailed != null) {
          onFailed();
        }
        break;
      case NativeAuthResultStatus.error:
        if (onError != null) {
          onError(result.failure!.code, result.failure?.message);
        }
        break;
      case NativeAuthResultStatus.dialogClicked:
        if (onDialogClicked != null) {
          onDialogClicked(result.dialogClickResult!.which);
        }
        break;
      case NativeAuthResultStatus.canceled:
        if (onCanceled != null) {
          onCanceled();
        }
        break;
    }
  }

  @override
  Future<void> secureEncryptAuthenticate({
    required String key,
    Map<String, String>? requestForEncrypt,
    required String title,
    required String description,
    required String negativeText,
    required Function(String? encodedIVKey, Map<String, String?>? encryptedResult) onSuccessAuthenticate,
    Function()? onFailed,
    Function(String code, String? message)? onError,
    Function(int which)? onDialogClicked,
    Function()? onCanceled,
  }) async {
    assert(requestForEncrypt != null, true);

    final result = await _api.secureEncryptAuthenticate(
      alias: key,
      requestForEncrypt: requestForEncrypt!,
      title: title,
      description: description,
      negativeText: negativeText,
    );
    switch (result.status) {
      case NativeAuthResultStatus.success:
        onSuccessAuthenticate(result.encodedIVKey!, result.encryptedResult!);
        break;
      case NativeAuthResultStatus.failed:
        if (onFailed != null) {
          onFailed();
        }
        break;
      case NativeAuthResultStatus.error:
        if (onError != null) {
          onError(result.failure!.code, result.failure?.message);
        }
        break;
      case NativeAuthResultStatus.dialogClicked:
        if (onDialogClicked != null) {
          onDialogClicked(result.dialogClickResult!.which);
        }
        break;
      case NativeAuthResultStatus.canceled:
        if (onCanceled != null) {
          onCanceled();
        }
        break;
    }
  }

  @override
  Future<void> secureDecryptAuthenticate({
    required String key,
    String? encodedIVKey,
    Map<String, String>? requestForDecrypt,
    required String title,
    required String description,
    required String negativeText,
    required Function(Map<String, String?>? decryptedResult) onSuccessAuthenticate,
    Function()? onFailed,
    Function(String code, String? message)? onError,
    Function(int which)? onDialogClicked,
    Function()? onCanceled,
  }) async {
    assert(encodedIVKey != null, true);
    assert(requestForDecrypt != null, true);
    final result = await _api.secureDecryptAuthenticate(
      alias: key,
      encodedIVKey: encodedIVKey!,
      requestForDecrypt: requestForDecrypt!,
      title: title,
      description: description,
      negativeText: negativeText,
    );
    switch (result.status) {
      case NativeAuthResultStatus.success:
        onSuccessAuthenticate(result.decryptedResult!);
        break;
      case NativeAuthResultStatus.failed:
        if (onFailed != null) {
          onFailed();
        }
        break;
      case NativeAuthResultStatus.error:
        if (onError != null) {
          onError(result.failure!.code, result.failure?.message);
        }
        break;
      case NativeAuthResultStatus.dialogClicked:
        if (onDialogClicked != null) {
          onDialogClicked(result.dialogClickResult!.which);
        }
        break;
      case NativeAuthResultStatus.canceled:
        if (onCanceled != null) {
          onCanceled();
        }
        break;
    }
  }
}
