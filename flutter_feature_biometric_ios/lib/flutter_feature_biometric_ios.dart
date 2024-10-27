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
    NativeBiometricAuthenticatorType type;
    switch (authenticator) {
      case BiometricAuthenticatorType.biometric:
        type = NativeBiometricAuthenticatorType.biometric;
      case BiometricAuthenticatorType.deviceCredential:
        type = NativeBiometricAuthenticatorType.deviceCredential;
    }
    final canAuthenticate = await _hostApi.canAuthenticate(type);
    switch (canAuthenticate) {
      case true:
        return BiometricStatus.success;
      default:
        return BiometricStatus.unavailable;
    }
  }

  @override
  Future<bool> canSecureAuthenticate() async {
    return true;
  }

  @override
  Future<void> secureDecryptAuthenticate({
    required String key,
    required String encodedIVKey,
    required Map<String, String> requestForDecrypt,
    required String title,
    required String description,
    required String negativeText,
    required Function(Map<String, String?> decryptedResult) onSuccessAuthenticate,
    Function()? onFailed,
    Function(String code, String message)? onError,
    Function(int which)? onDialogClicked,
    Function()? onCanceled,
  }) async {
    final result = await _hostApi.authenticateSecure(
      NativeBiometricAuthenticatorType.biometric,
      key,
      description,
    );
    switch(result.status){
      case NativeAuthResultStatus.success:
        // TODO: Handle this case.
      case NativeAuthResultStatus.biometricChanged:
        // TODO: Handle this case.
      case NativeAuthResultStatus.canceled:
        // TODO: Handle this case.
    }
  }
}
