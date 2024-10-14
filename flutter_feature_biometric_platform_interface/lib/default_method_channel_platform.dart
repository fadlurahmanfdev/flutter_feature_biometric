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
  Future<bool> deviceSupportsBiometrics() {
    // TODO: implement deviceSupportsBiometrics
    return super.deviceSupportsBiometrics();
  }
}