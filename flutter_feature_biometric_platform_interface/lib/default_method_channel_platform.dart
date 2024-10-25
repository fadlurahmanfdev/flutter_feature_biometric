// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter_feature_biometric_platform_interface/src/model/biometric_authenticate_result.dart';
import 'flutter_feature_biometric_platform_interface.dart';

const MethodChannel _channel = MethodChannel('plugins.flutter.io/flutter_feature_biometric');

/// The default interface implementation acting as a placeholder for
/// the native implementation to be set.
///
/// This implementation is not used by any of the implementations in this
/// repository, and exists only for backward compatibility with any
/// clients that were relying on internal details of the method channel
/// in the pre-federated plugin.
class DefaultFlutterFeatureBiometricPlatform extends FlutterFeatureBiometricPlatform {
  @override
  Future<bool> isDeviceSupportBiometric() {
    // TODO: implement isDeviceSupportBiometric
    return super.isDeviceSupportBiometric();
  }

  @override
  Future<BiometricStatus> checkAuthenticationTypeStatus(BiometricAuthenticatorType authenticator) {
    // TODO: implement checkBiometricStatus
    return super.checkAuthenticationTypeStatus(authenticator);
  }

  @override
  Future<BiometricAuthenticateResult> authenticate({
    required BiometricAuthenticatorType authenticator,
    required String title,
    required String description,
    required String negativeText,
  }) async {
    // TODO: implement authenticate
    return super.authenticate(
      authenticator: authenticator,
      title: title,
      description: description,
      negativeText: negativeText,
    );
  }


  @override
  Future<void> secureEncryptAuthenticate({
    required String key,
    required Map<String, String> requestForEncrypt,
    required String title,
    required String description,
    required String negativeText,
    required Function(String encodedIVKey, Map<String, String?> encryptedResult) onSuccessAuthenticate,
    Function()? onFailed,
    Function(String code, String message)? onError,
    Function(int which)? onDialogClicked,
  }) async {
    // TODO: implement secureEncryptAuthenticate
    return super.secureEncryptAuthenticate(
      key: key,
      requestForEncrypt: requestForEncrypt,
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
