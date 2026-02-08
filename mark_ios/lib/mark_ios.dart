// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:mark_ios/src/constant/error_constant.dart';
import 'package:mark_platform_interface/mark_platform_interface.dart';

import 'src/messages.g.dart';

/// An implementation of [MarkPlatform] for iOS.
class MarkIOS extends MarkPlatform {
  /// Creates a new plugin implementation instance.
  MarkIOS({
    @visibleForTesting MarkApi? api,
  }) : _api = api ?? MarkApi();

  final MarkApi _api;

  /// Registers this class as the default instance of [MarkPlatform].
  static void registerWith() {
    MarkPlatform.instance = MarkIOS();
  }

  @override
  Future<bool> isDeviceSupportBiometric() {
    return _api.isDeviceSupportBiometric();
  }

  @override
  Future<MarkAuthenticatorStatus> checkAuthenticatorStatus(MarkAuthenticatorType authenticatorType) async {
    IOSLAPolicy laPolicy;
    switch (authenticatorType) {
      case MarkAuthenticatorType.biometric:
        laPolicy = IOSLAPolicy.biometric;
      case MarkAuthenticatorType.deviceCredential:
        laPolicy = IOSLAPolicy.deviceCredential;
    }
    final canAuthenticate = await _api.canAuthenticate(laPolicy: laPolicy);
    switch (canAuthenticate) {
      case true:
        return MarkAuthenticatorStatus.success;
      default:
        return MarkAuthenticatorStatus.noneEnrolled;
    }
  }

  @override
  Future<bool> canSecureAuthenticate() async {
    return true;
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
    try {
      IOSLAPolicy laPolicy;
      switch (authenticatorType) {
        case MarkAuthenticatorType.biometric:
          laPolicy = IOSLAPolicy.biometric;
          break;
        case MarkAuthenticatorType.deviceCredential:
          laPolicy = IOSLAPolicy.deviceCredential;
          break;
        default:
          throw FeatureBiometricException(
            code: ErrorConstantIOS.IOS_UNKNOWN_POLICY,
            message:
                'Unknown policy other than ${MarkAuthenticatorType.biometric} or ${MarkAuthenticatorType.deviceCredential}',
          );
      }
      final result = await _api.authenticate(
        laPolicy: laPolicy,
        description: description,
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
          onErrorAuthenticate(ErrorConstantIOS.IOS_UNKNOWN_RESULT, 'Unknown result: ${result.status}');
          break;
      }
    } on FeatureBiometricException catch(e){
      onErrorAuthenticate(e.code, e.message);
    } catch (e) {
      onErrorAuthenticate(ErrorConstantIOS.IOS_UNKNOWN_UNABLE_AUTHENTICATE, '$e');
    }
  }

  @override
  Future<bool> isBiometricChanged({required String alias, required String encodedKey}) async {
    return _api.isBiometricChanged(alias: alias, encodedDomainState: encodedKey);
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
    final result = await _api.authenticateSecureEncrypt(
      laPolicy: IOSLAPolicy.biometric,
      alias: alias,
      description: description,
    );
    switch (result.status) {
      case IOSAuthenticationResultStatus.success:
        onSuccessAuthenticate(SuccessAuthenticateEncryptIOS(encodedDomainState: result.encodedDomainState!));
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
    final result = await _api.authenticateSecureDecrypt(
      laPolicy: IOSLAPolicy.biometric,
      alias: alias,
      encodedDomainState: encodedKey,
      description: description,
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
