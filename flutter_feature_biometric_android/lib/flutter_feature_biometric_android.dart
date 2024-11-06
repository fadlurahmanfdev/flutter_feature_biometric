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
  Future<AuthenticatorStatus> checkAuthenticatorStatus(BiometricAuthenticatorType authenticatorType) async {
    AndroidAuthenticatorStatus authenticatorStatus;
    switch (authenticatorType) {
      case BiometricAuthenticatorType.biometric:
        authenticatorStatus = await _api.checkAuthenticatorStatus(AndroidAuthenticatorType.biometric);
      case BiometricAuthenticatorType.deviceCredential:
        authenticatorStatus = await _api.checkAuthenticatorStatus(AndroidAuthenticatorType.deviceCredential);
    }
    switch (authenticatorStatus) {
      case AndroidAuthenticatorStatus.success:
        return AuthenticatorStatus.success;
      case AndroidAuthenticatorStatus.noHardwareAvailable:
        return AuthenticatorStatus.noHardwareAvailable;
      case AndroidAuthenticatorStatus.unavailable:
        return AuthenticatorStatus.unavailable;
      case AndroidAuthenticatorStatus.noneEnrolled:
        return AuthenticatorStatus.noneEnrolled;
      case AndroidAuthenticatorStatus.securityUpdateRequired:
        return AuthenticatorStatus.securityUpdateRequired;
      case AndroidAuthenticatorStatus.unsupportedOSVersion:
        return AuthenticatorStatus.unsupportedOSVersion;
      default:
        return AuthenticatorStatus.unknown;
    }
  }

  @override
  Future<bool> canSecureAuthenticate() async {
    return (await _api.checkSecureAuthenticatorStatus()) == AndroidAuthenticatorStatus.success;
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
    final result = await _api.authenticateDeviceCredential(
      title: title,
      description: description,
      negativeText: negativeText,
      confirmationRequired: confirmationRequired,
    );
    switch (result.status) {
      case AndroidAuthenticationResultStatus.success:
        onSuccessAuthenticate();
        break;
      case AndroidAuthenticationResultStatus.canceled:
        if (onCanceled != null) {
          onCanceled();
        }
        break;
      case AndroidAuthenticationResultStatus.failed:
        if (onFailedAuthenticate != null) {
          onFailedAuthenticate();
        }
        break;
      case AndroidAuthenticationResultStatus.error:
        onErrorAuthenticate(result.failure!.code, result.failure?.message);
        break;
      case AndroidAuthenticationResultStatus.negativeButtonClicked:
        if (onNegativeButtonClicked != null) {
          onNegativeButtonClicked();
        }
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
    final result = await _api.authenticateBiometric(
      title: title,
      description: description,
      negativeText: negativeText,
      confirmationRequired: confirmationRequired,
    );
    switch (result.status) {
      case AndroidAuthenticationResultStatus.success:
        onSuccessAuthenticate();
        break;
      case AndroidAuthenticationResultStatus.canceled:
        if (onCanceled != null) {
          onCanceled();
        }
        break;
      case AndroidAuthenticationResultStatus.failed:
        if (onFailedAuthenticate != null) {
          onFailedAuthenticate();
        }
        break;
      case AndroidAuthenticationResultStatus.error:
        onErrorAuthenticate(result.failure!.code, result.failure?.message);
        break;
      case AndroidAuthenticationResultStatus.negativeButtonClicked:
        if (onNegativeButtonClicked != null) {
          onNegativeButtonClicked();
        }
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
    final result = await _api.authenticateBiometricSecureEncrypt(
      alias: key,
      requestForEncrypt: requestForEncrypt,
      title: title,
      description: description,
      negativeText: negativeText,
      confirmationRequired: true,
    );
    switch (result.status) {
      case AndroidAuthenticationResultStatus.success:
        onSuccessAuthenticate(
          SuccessAuthenticateEncryptAndroid(
            encodedIVKey: result.encodedIVKey!,
            encryptedResult: result.encryptedResult!,
          ),
        );
        break;
      case AndroidAuthenticationResultStatus.failed:
        if (onFailedAuthenticate != null) {
          onFailedAuthenticate();
        }
        break;
      case AndroidAuthenticationResultStatus.error:
        onErrorAuthenticate(result.failure!.code, result.failure?.message);
        break;
      case AndroidAuthenticationResultStatus.negativeButtonClicked:
        if (onNegativeButtonClicked != null) {
          onNegativeButtonClicked();
        }
        break;
      case AndroidAuthenticationResultStatus.canceled:
        if (onCanceled != null) {
          onCanceled();
        }
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
    final result = await _api.authenticateBiometricSecureDecrypt(
      alias: key,
      encodedIVKey: encodedIVKey,
      requestForDecrypt: requestForDecrypt,
      title: title,
      description: description,
      negativeText: negativeText,
      confirmationRequired: true,
    );
    switch (result.status) {
      case AndroidAuthenticationResultStatus.success:
        onSuccessAuthenticate(SuccessAuthenticateDecryptAndroid(decryptedResult: result.decryptedResult!));
        break;
      case AndroidAuthenticationResultStatus.failed:
        if (onFailedAuthenticate != null) {
          onFailedAuthenticate();
        }
        break;
      case AndroidAuthenticationResultStatus.error:
        onErrorAuthenticate(result.failure!.code, result.failure?.message);
        break;
      case AndroidAuthenticationResultStatus.negativeButtonClicked:
        if (onNegativeButtonClicked != null) {
          onNegativeButtonClicked();
        }
        break;
      case AndroidAuthenticationResultStatus.canceled:
        if (onCanceled != null) {
          onCanceled();
        }
        break;
    }
  }
}
