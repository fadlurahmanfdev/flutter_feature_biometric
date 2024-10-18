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
  Future<bool> isDeviceSupportFaceAuth() {
    // TODO: implement isSupportFaceAuth
    return super.isDeviceSupportFaceAuth();
  }

  @override
  Future<BiometricStatus> checkBiometricStatus(BiometricAuthenticator authenticator) async {
    NativeBiometricAuthenticator nativeAuthenticator;
    switch (authenticator) {
      case BiometricAuthenticator.weak:
        nativeAuthenticator = NativeBiometricAuthenticator.weak;
      case BiometricAuthenticator.strong:
        nativeAuthenticator = NativeBiometricAuthenticator.strong;
      case BiometricAuthenticator.deviceCredential:
        nativeAuthenticator = NativeBiometricAuthenticator.deviceCredential;
    }
    final nativeStatus = await _api.checkBiometricStatus(nativeAuthenticator);
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
  Future<BiometricAuthenticateResult> authenticate({
    required BiometricAuthenticator authenticator,
    required String title,
    required String description,
    required String negativeText,
  }) async {
    NativeBiometricAuthenticator nativeAuthenticator;
    switch (authenticator) {
      case BiometricAuthenticator.weak:
        nativeAuthenticator = NativeBiometricAuthenticator.weak;
      case BiometricAuthenticator.strong:
        nativeAuthenticator = NativeBiometricAuthenticator.strong;
      case BiometricAuthenticator.deviceCredential:
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
        return BiometricAuthenticateResult(status: BiometricAuthenticateStatus.success);
      case NativeAuthResultStatus.failed:
        return BiometricAuthenticateResult(status: BiometricAuthenticateStatus.failed);
      case NativeAuthResultStatus.error:
        return BiometricAuthenticateResult(status: BiometricAuthenticateStatus.error);
      case NativeAuthResultStatus.dialogClicked:
        return BiometricAuthenticateResult(
          status: BiometricAuthenticateStatus.dialogClicked,
          dialogClickResult: BiometricAuthenticateDialogClickResult(
            which: result.dialogClickResult?.which ?? -1,
          ),
        );
    }
  }
}
