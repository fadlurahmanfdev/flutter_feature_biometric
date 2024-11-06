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
  Future<AuthenticatorStatus> checkAuthenticatorStatus(BiometricAuthenticatorType authenticatorType) async {
    IOSLAPolicy policy;
    switch (authenticatorType) {
      case BiometricAuthenticatorType.biometric:
        policy = IOSLAPolicy.biometric;
      case BiometricAuthenticatorType.deviceCredential:
        policy = IOSLAPolicy.deviceCredential;
    }
    final canAuthenticate = await _hostApi.canAuthenticate(policy);
    switch (canAuthenticate) {
      case true:
        return AuthenticatorStatus.success;
      default:
        return AuthenticatorStatus.noneEnrolled;
    }
  }

  @override
  Future<bool> canSecureAuthenticate() async {
    return true;
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
    Function()? onNegativeButtonClicked,
    Function()? onCanceled,
  }) async {
    final result = await _hostApi.authenticate(
      IOSLAPolicy.deviceCredential,
      description,
    );

    switch (result.status) {
      case IOSAuthenticationResultStatus.success:
        onSuccessAuthenticate();
        break;
      case IOSAuthenticationResultStatus.canceled:
        if (onCanceled != null) {
          onCanceled();
        }
        break;
      default:
        onErrorAuthenticate("UNKNOWN_STATUS", "IOS_FAILURE");
        break;
    }
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
    Function()? onNegativeButtonClicked,
    Function()? onCanceled,
  }) async {
    final result = await _hostApi.authenticate(
      IOSLAPolicy.biometric,
      description,
    );
    switch (result.status) {
      case IOSAuthenticationResultStatus.success:
        onSuccessAuthenticate();
        break;
      case IOSAuthenticationResultStatus.canceled:
        if (onCanceled != null) {
          onCanceled();
        }
        break;
      default:
        onErrorAuthenticate("UNKNOWN_STATUS", "IOS_FAILURE");
        break;
    }
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
    Function()? onNegativeButtonClicked,
    Function()? onCanceled,
  }) async {
    final result = await _hostApi.authenticateSecure(
      IOSLAPolicy.biometric,
      key,
      description,
    );
    switch (result.status) {
      case IOSAuthenticationResultStatus.success:
        onSuccessAuthenticate(SuccessAuthenticateEncryptIOS());
        break;
      case IOSAuthenticationResultStatus.biometricChanged:
        onErrorAuthenticate("BIOMETRIC_CHANGED", null);
        break;
      case IOSAuthenticationResultStatus.canceled:
        if (onCanceled != null) {
          onCanceled();
        }
        break;
      default:
        onErrorAuthenticate("GENERAL", null);
        break;
    }
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
    Function()? onNegativeButtonClicked,
    Function()? onCanceled,
  }) async {
    final result = await _hostApi.authenticateSecure(
      IOSLAPolicy.biometric,
      key,
      description,
    );
    switch (result.status) {
      case IOSAuthenticationResultStatus.success:
        onSuccessAuthenticate(SuccessAuthenticateDecryptIOS());
        break;
      case IOSAuthenticationResultStatus.biometricChanged:
        onErrorAuthenticate("BIOMETRIC_CHANGED", "-");
        break;
      case IOSAuthenticationResultStatus.canceled:
        if (onCanceled != null) {
          onCanceled();
        }
        break;
      default:
        onErrorAuthenticate("GENERAL", null);
        break;
    }
  }
}
