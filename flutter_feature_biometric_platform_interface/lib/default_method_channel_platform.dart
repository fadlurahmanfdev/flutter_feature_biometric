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
  Future<bool> isDeviceSupportFaceAuth() {
    // TODO: implement isDeviceSupportFaceAuth
    return super.isDeviceSupportFaceAuth();
  }

  @override
  Future<BiometricStatus> checkBiometricStatus(BiometricAuthenticator authenticator) {
    // TODO: implement checkBiometricStatus
    return super.checkBiometricStatus(authenticator);
  }

  @override
  Future<BiometricAuthenticateResult> authenticate({
    required BiometricAuthenticator authenticator,
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
}
