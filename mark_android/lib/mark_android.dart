// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:mark_android/src/messages.g.dart';
import 'package:mark_platform_interface/mark_platform_interface.dart';
export 'package:mark_platform_interface/mark_platform_interface.dart';

/// The implementation of [MarkPlatform] for Android.
class MarkAndroid extends MarkPlatform {
  /// Creates a new plugin implementation instance.
  MarkAndroid({
    @visibleForTesting MarkApi? api,
  }) : _api = api ?? MarkApi();

  /// Registers this class as the default instance of [MarkPlatform].
  static void registerWith() {
    MarkPlatform.instance = MarkAndroid();
  }

  final MarkApi _api;

  @override
  Future<bool> isDeviceSupportBiometric() async {
    return _api.isDeviceSupportBiometric();
  }

  @override
  Future<MarkAuthenticatorStatus> checkAuthenticatorStatus(MarkAuthenticatorType authenticatorType) async {
    AndroidAuthenticatorStatus authenticatorStatus;
    switch (authenticatorType) {
      case MarkAuthenticatorType.biometric:
        authenticatorStatus = await _api.checkAuthenticatorStatus(AndroidAuthenticatorType.biometric);
      case MarkAuthenticatorType.deviceCredential:
        authenticatorStatus = await _api.checkAuthenticatorStatus(AndroidAuthenticatorType.deviceCredential);
    }
    switch (authenticatorStatus) {
      case AndroidAuthenticatorStatus.success:
        return MarkAuthenticatorStatus.success;
      case AndroidAuthenticatorStatus.noHardwareAvailable:
        return MarkAuthenticatorStatus.noHardwareAvailable;
      case AndroidAuthenticatorStatus.unavailable:
        return MarkAuthenticatorStatus.unavailable;
      case AndroidAuthenticatorStatus.noneEnrolled:
        return MarkAuthenticatorStatus.noneEnrolled;
      case AndroidAuthenticatorStatus.securityUpdateRequired:
        return MarkAuthenticatorStatus.securityUpdateRequired;
      case AndroidAuthenticatorStatus.unsupportedOSVersion:
        return MarkAuthenticatorStatus.unsupportedOSVersion;
      default:
        return MarkAuthenticatorStatus.unknown;
    }
  }

  @override
  Future<bool> canSecureAuthenticate() async {
    return (await _api.checkSecureAuthenticatorStatus()) == AndroidAuthenticatorStatus.success;
  }

  @override
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
  }) async {
    AndroidAuthenticationResult result;

    switch (authenticatorType) {
      case MarkAuthenticatorType.biometric:
        result = await _api.authenticateBiometric(
          title: title,
          description: description,
          negativeText: negativeText,
          confirmationRequired: confirmationRequired,
        );
        break;
      case MarkAuthenticatorType.deviceCredential:
        result = await _api.authenticateDeviceCredential(
          title: title,
          description: description,
          negativeText: negativeText,
          confirmationRequired: confirmationRequired,
        );
        break;
    }
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
          onNegativeButtonClicked(result.negativeButtonClickResult!.which);
        }
        break;
    }
  }

  @override
  Future<bool> isBiometricChanged({required String alias, required String encodedKey}) {
    return _api.isBiometricChanged(alias: alias);
  }

  @override
  Future<void> authenticateSecureEncrypt({
    required String alias,
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
    final result = await _api.authenticateBiometricSecureEncrypt(
      alias: alias,
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
          onNegativeButtonClicked(result.negativeButtonClickResult!.which);
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
    required String alias,
    required String encodedKey,
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
  }) async {
    final result = await _api.authenticateBiometricSecureDecrypt(
      alias: alias,
      encodedIVKey: encodedKey,
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
          onNegativeButtonClicked(result.negativeButtonClickResult!.which);
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
