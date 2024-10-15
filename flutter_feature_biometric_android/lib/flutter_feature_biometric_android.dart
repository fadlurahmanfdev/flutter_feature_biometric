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
  Future<bool> deviceSupportsBiometrics() async {
    return _api.deviceCanSupportBiometrics();
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
  Future<void> authenticate({required BiometricAuthenticator authenticator, required String title, required String description, required String negativeText}) {
    NativeBiometricAuthenticator nativeAuthenticator;
    switch (authenticator) {
      case BiometricAuthenticator.weak:
        nativeAuthenticator = NativeBiometricAuthenticator.weak;
      case BiometricAuthenticator.strong:
        nativeAuthenticator = NativeBiometricAuthenticator.strong;
      case BiometricAuthenticator.deviceCredential:
        nativeAuthenticator = NativeBiometricAuthenticator.deviceCredential;
    }

    return _api.authenticate(authenticator: nativeAuthenticator, title: title, description: description, negativeText: negativeText);
  }
}
