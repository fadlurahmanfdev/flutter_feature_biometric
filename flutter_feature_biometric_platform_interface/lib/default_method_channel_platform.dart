// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
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
  Future<AuthenticatorStatus> checkAuthenticatorStatus(BiometricAuthenticatorType authenticatorType) {
    // TODO: implement checkBiometricStatus
    return super.checkAuthenticatorStatus(authenticatorType);
  }

  @override
  Future<void> authenticateDeviceCredential({
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
  }) async {
    // TODO: implement authenticateDeviceCredential
    return super.authenticateDeviceCredential(
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

  @override
  Future<void> authenticateBiometric({
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
  }) async {
    // TODO: implement authenticateBiometric
    return super.authenticateBiometric(
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

  @override
  Future<void> authenticateSecureEncrypt({
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
  }) async {
    // TODO: implement secureEncryptAuthenticate
    return super.authenticateSecureEncrypt(
      key: key,
      requestForEncrypt: requestForEncrypt,
      title: title,
      description: description,
      negativeText: negativeText,
      onSuccessAuthenticate: onSuccessAuthenticate,
      onFailedAuthenticate: onFailedAuthenticate,
      onErrorAuthenticate: onErrorAuthenticate,
      onNegativeButtonClicked: onNegativeButtonClicked,
    );
  }

  @override
  Future<void> authenticateSecureDecrypt({
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
    // TODO: implement secureEncryptAuthenticate
    return super.authenticateSecureDecrypt(
      key: key,
      encodedIVKey: encodedIVKey,
      requestForDecrypt: requestForDecrypt,
      title: title,
      description: description,
      negativeText: negativeText,
      onSuccessAuthenticate: onSuccessAuthenticate,
      onFailedAuthenticate: onFailedAuthenticate,
      onErrorAuthenticate: onErrorAuthenticate,
      onNegativeButtonClicked: onNegativeButtonClicked,
    );
  }
}
