// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter_feature_biometric_platform_interface/src/enum/check_biometric_status.dart';
import 'package:flutter_feature_biometric_platform_interface/src/enum/feature_biometric_type.dart';

import 'flutter_feature_biometric_platform_interface.dart';

const MethodChannel _channel = MethodChannel('plugins.com.fadlurahmanfdev/flutter_feature_biometric');

/// The default interface implementation acting as a placeholder for
/// the native implementation to be set.
///
/// This implementation is not used by any of the implementations in this
/// repository, and exists only for backward compatibility with any
/// clients that were relying on internal details of the method channel
/// in the pre-federated plugin.
class DefaultFlutterFeatureBiometricPlatform extends FlutterFeatureBiometricPlatform {
  @override
  Future<bool> isDeviceSupportedBiometric() async {
    final List<String> availableBiometrics = (await _channel.invokeListMethod<String>(
          'getAvailableBiometrics',
        )) ??
        <String>[];
    // If anything, including the 'undefined' sentinel, is returned, then there
    // is device support for biometrics.
    return availableBiometrics.isNotEmpty;
  }

  @override
  Future<bool> canAuthenticate(FeatureBiometricType type) {
    // TODO: implement canAuthenticate
    throw UnimplementedError();
  }

  @override
  Future<CheckBiometricStatus> checkBiometricStatus(FeatureBiometricType type) {
    // TODO: implement checkBiometricStatus
    throw UnimplementedError();
  }

@override
  Future<void> authenticate({required FeatureBiometricType type, required String title, required String description, required String negativeText}) {
    // TODO: implement authenticate
    throw UnimplementedError();
  }
}
