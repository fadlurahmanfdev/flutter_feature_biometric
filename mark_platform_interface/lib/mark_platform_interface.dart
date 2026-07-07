// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

export 'src/enum/mark_authenticator_type.dart';
export 'src/enum/mark_authenticator_status.dart';

export 'src/exception/mark_exception.dart';

export 'src/state/success_authenticate_encrypt_state.dart';
export 'src/state/success_authenticate_decrypt_state.dart';

import 'package:mark_platform_interface/src/enum/mark_authenticator_type.dart';
import 'package:mark_platform_interface/src/enum/mark_authenticator_status.dart';
import 'package:mark_platform_interface/src/state/success_authenticate_decrypt_state.dart';
import 'package:mark_platform_interface/src/state/success_authenticate_encrypt_state.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'default_method_channel_platform.dart';

/// Platform interface used by all biometric platform implementations.
///
/// Platform implementations should use `extends` instead of `implements`
/// so new methods can be added safely with default behavior.
abstract class MarkPlatform extends PlatformInterface {
  /// Constructs a MarkPlatform.
  MarkPlatform() : super(token: _token);

  static final Object _token = Object();

  static MarkPlatform _instance = DefaultMarkPlatform();

  /// The default instance of [MarkPlatform] to use.
  ///
  /// Defaults to [DefaultMarkPlatform].
  static MarkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MarkPlatform] when they
  /// register themselves.
  static set instance(MarkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Returns `true` when the device supports biometric capability.
  Future<bool> isDeviceSupportBiometric() async {
    throw UnimplementedError('isDeviceSupportBiometric() has not been implemented.');
  }

  /// Returns availability status for the requested [authenticatorType].
  Future<MarkAuthenticatorStatus> checkAuthenticatorStatus(MarkAuthenticatorType authenticatorType) async {
    throw UnimplementedError('checkAuthenticationTypeStatus() has not been implemented.');
  }

  /// Returns `true` when secure encrypt/decrypt flow is available.
  Future<bool> canSecureAuthenticate() async {
    throw UnimplementedError('isSupportSecureBiometric() has not been implemented.');
  }

  /// Starts standard authentication flow.
  ///
  /// Implementations should call one of the callbacks based on native result.
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
    throw UnimplementedError('authenticate() has not been implemented.');
  }

  /// Returns `true` when biometric enrollment has changed for the given key.
  Future<bool> isBiometricChanged({required String alias, required String encodedKey}) async {
    throw UnimplementedError('isBiometricChanged() has not been implemented.');
  }

  /// Authenticates and encrypts data in [requestForEncrypt].
  ///
  /// Implementations must return platform-specific success state.
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

  /// Authenticates and decrypts data in [requestForDecrypt].
  ///
  /// Implementations must return platform-specific success state.
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
