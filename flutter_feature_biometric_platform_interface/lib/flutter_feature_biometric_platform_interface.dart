// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

export 'src/enum/feature_authenticator_type.dart';
export 'src/enum/feature_authenticator_status.dart';

export 'src/exception/feature_biometric_exception.dart';

export 'src/state/success_authenticate_encrypt_state.dart';
export 'src/state/success_authenticate_decrypt_state.dart';

import 'package:flutter_feature_biometric_platform_interface/src/enum/feature_authenticator_type.dart';
import 'package:flutter_feature_biometric_platform_interface/src/enum/feature_authenticator_status.dart';
import 'package:flutter_feature_biometric_platform_interface/src/state/success_authenticate_decrypt_state.dart';
import 'package:flutter_feature_biometric_platform_interface/src/state/success_authenticate_encrypt_state.dart';
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

  Future<bool> isDeviceSupportBiometric() async {
    throw UnimplementedError('isDeviceSupportBiometric() has not been implemented.');
  }

  Future<FeatureAuthenticatorStatus> checkAuthenticatorStatus(FeatureAuthenticatorType authenticatorType) async {
    throw UnimplementedError('checkAuthenticationTypeStatus() has not been implemented.');
  }

  Future<bool> canSecureAuthenticate() async {
    throw UnimplementedError('isSupportSecureBiometric() has not been implemented.');
  }

  Future<void> authenticate({
    required FeatureAuthenticatorType authenticatorType,
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
    throw UnimplementedError('authenticate() has not been implemented.');
  }

  Future<bool> isBiometricChanged({required String alias, required String encodedKey}) async {
    throw UnimplementedError('isBiometricChanged() has not been implemented.');
  }

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
    throw UnimplementedError('authenticateSecureEncrypt() has not been implemented.');
  }

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
    throw UnimplementedError('authenticateSecureDecrypt() has not been implemented.');
  }
}
