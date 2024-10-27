// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';

import 'src/messages.g.dart';

/// An implementation of [FlutterFeatureBiometricPlatform] for iOS.
class FlutterFeatureBiometricIOS extends FlutterFeatureBiometricPlatform {
  /// Creates a new plugin implementation instance.
  FlutterFeatureBiometricIOS({
    @visibleForTesting FlutterFeatureBiometricApi? api,
  }) : _hostApi = api ?? FlutterFeatureBiometricApi();

  final FlutterFeatureBiometricApi _hostApi;

  /// Registers this class as the default instance of [FlutterFeatureBiometricPlatform].
  static void registerWith() {
    FlutterFeatureBiometricPlatform.instance = FlutterFeatureBiometricIOS();
  }

  @override
  Future<bool> isDeviceSupportBiometric() {
    return _hostApi.isDeviceSupportBiometric();
  }

  @override
  Future<BiometricStatus> checkAuthenticationTypeStatus(BiometricAuthenticatorType authenticator) async {
    NativeLAPolicy policy;
    switch (authenticator) {
      case BiometricAuthenticatorType.biometric:
        policy = NativeLAPolicy.biometric;
      case BiometricAuthenticatorType.deviceCredential:
        policy = NativeLAPolicy.deviceCredential;
    }
    final canAuthenticate = await _hostApi.canAuthenticate(policy);
    switch (canAuthenticate) {
      case true:
        return BiometricStatus.success;
      default:
        return BiometricStatus.noneEnrolled;
    }
  }

  @override
  Future<bool> canSecureAuthenticate() async {
    return true;
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
    NativeLAPolicy policy;
    switch (authenticator) {
      case BiometricAuthenticatorType.biometric:
        policy = NativeLAPolicy.biometric;
      case BiometricAuthenticatorType.deviceCredential:
        policy = NativeLAPolicy.deviceCredential;
    }

    final result = await _hostApi.authenticate(
      policy,
      description,
    );
    switch (result.status) {
      case NativeAuthResultStatus.success:
        onSuccessAuthenticate();
        break;
      case NativeAuthResultStatus.biometricChanged:
        if (onError != null) {
          onError("-", "-");
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
    Function(String code, String message)? onError,
    Function(int which)? onDialogClicked,
    Function()? onCanceled,
  }) async {
    final result = await _hostApi.authenticateSecure(
      NativeLAPolicy.biometric,
      key,
      description,
    );
    switch (result.status) {
      case NativeAuthResultStatus.success:
        onSuccessAuthenticate(null);
        break;
      case NativeAuthResultStatus.biometricChanged:
        if (onError != null) {
          onError("-", "-");
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
