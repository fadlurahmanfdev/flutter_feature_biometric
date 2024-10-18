// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

export 'src/enum/biometric_authenticate_status.dart';
export 'src/enum/biometric_authenticator.dart';

export 'src/enum/biometric_status.dart';
export 'src/model/biometric_authenticate_result.dart';

import 'package:flutter_feature_biometric_platform_interface/src/enum/biometric_authenticator.dart';
import 'package:flutter_feature_biometric_platform_interface/src/enum/biometric_status.dart';
import 'package:flutter_feature_biometric_platform_interface/src/model/biometric_authenticate_result.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'default_method_channel_platform.dart';

/// The interface that implementations of local_auth must implement.
///
/// Platform implementations should extend this class rather than implement it as `local_auth`
/// does not consider newly added methods to be breaking changes. Extending this class
/// (using `extends`) ensures that the subclass will get the default implementation, while
/// platform implementations that `implements` this interface will be broken by newly added
/// [FlutterFeatureBiometricPlatform] methods.
abstract class FlutterFeatureBiometricPlatform extends PlatformInterface {
  /// Constructs a FlutterFeatureBiometricPlatform.
  FlutterFeatureBiometricPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterFeatureBiometricPlatform _instance = DefaultFlutterFeatureBiometricPlatform();

  /// The default instance of [FlutterFeatureBiometricPlatform] to use.
  ///
  /// Defaults to [DefaultFlutterFeatureBiometricPlatform].
  static FlutterFeatureBiometricPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterFeatureBiometricPlatform] when they
  /// register themselves.
  static set instance(FlutterFeatureBiometricPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Returns true if the device is capable of checking biometrics.
  ///
  /// This will return true even if there are no biometrics currently enrolled.
  Future<bool> isDeviceSupportBiometric() async {
    throw UnimplementedError('isDeviceSupportBiometric() has not been implemented.');
  }

  Future<bool> isDeviceSupportFaceAuth(){
    throw UnimplementedError('isDeviceSupportFaceAuth() has not been implemented.');
  }

  Future<BiometricStatus> checkBiometricStatus(BiometricAuthenticator authenticator) async {
    throw UnimplementedError('checkBiometricStatus() has not been implemented.');
  }

  Future<BiometricAuthenticateResult> authenticate({
    required BiometricAuthenticator authenticator,
    required String title,
    required String description,
    required String negativeText,
  }) async {
    throw UnimplementedError('authenticate() has not been implemented.');
  }
}
