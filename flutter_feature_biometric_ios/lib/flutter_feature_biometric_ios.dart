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
    print("masuk ios sini");
    return _hostApi.isDeviceSupportBiometric();
  }
}