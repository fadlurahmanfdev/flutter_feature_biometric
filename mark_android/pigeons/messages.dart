// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  kotlinOut: 'android/src/main/kotlin/com/fadlurahmanfdev/mark_android/Messages.kt',
  kotlinOptions: KotlinOptions(package: 'com.fadlurahmanfdev.mark_android'),
  copyrightHeader: 'pigeons/copyright.txt',
))
enum AndroidAuthenticatorStatus {
  success,
  noHardwareAvailable,
  unavailable,
  noneEnrolled,
  securityUpdateRequired,
  unsupportedOSVersion,
  unknown,
}

enum AndroidAuthenticatorType {
  biometric,
  deviceCredential,
}

enum AndroidAuthenticationResultStatus {
  success,
  canceled,
  failed,
  error,
  negativeButtonClicked,
}

class AndroidAuthenticationFailure {
  String code;
  String? message;

  AndroidAuthenticationFailure({
    required this.code,
    this.message,
  });
}

class AndroidAuthenticationNegativeButtonClickResult {
  int which;

  AndroidAuthenticationNegativeButtonClickResult({
    required this.which,
  });
}

class AndroidAuthenticationResult {
  AndroidAuthenticationResultStatus status;
  AndroidAuthenticationFailure? failure;
  AndroidAuthenticationNegativeButtonClickResult? negativeButtonClickResult;

  AndroidAuthenticationResult({
    required this.status,
    this.failure,
    this.negativeButtonClickResult,
  });
}

class AndroidSecureEncryptAuthResult {
  AndroidAuthenticationResultStatus status;
  String? encodedIVKey;
  Map<String, String?>? encryptedResult;
  AndroidAuthenticationFailure? failure;
  AndroidAuthenticationNegativeButtonClickResult? negativeButtonClickResult;

  AndroidSecureEncryptAuthResult({
    required this.status,
    this.encodedIVKey,
    this.encryptedResult,
    this.failure,
    this.negativeButtonClickResult,
  });
}

class AndroidSecureDecryptAuthResult {
  AndroidAuthenticationResultStatus status;
  Map<String, String?>? decryptedResult;
  AndroidAuthenticationFailure? failure;
  AndroidAuthenticationNegativeButtonClickResult? negativeButtonClickResult;

  AndroidSecureDecryptAuthResult({
    required this.status,
    this.decryptedResult,
    this.failure,
    this.negativeButtonClickResult,
  });
}

@HostApi()
abstract class MarkApi {
  void deleteSecretKey(String alias);

  bool isDeviceSupportFingerprint();

  bool isDeviceSupportFaceAuth();

  bool isDeviceSupportBiometric();

  bool isFingerprintEnrolled();

  bool isDeviceCredentialEnrolled();

  AndroidAuthenticatorStatus checkAuthenticatorStatus(AndroidAuthenticatorType androidAuthenticatorType);

  AndroidAuthenticatorStatus checkSecureAuthenticatorStatus();

  bool canAuthenticate({
    required AndroidAuthenticatorType androidAuthenticatorType,
  });

  @async
  AndroidAuthenticationResult authenticateDeviceCredential({
    required String title,
    String? subTitle,
    required String description,
    required String negativeText,
    required bool confirmationRequired,
  });

  @async
  AndroidAuthenticationResult authenticateBiometric({
    required String title,
    String? subTitle,
    required String description,
    required String negativeText,
    required bool confirmationRequired,
  });

  bool isBiometricChanged({
    required String alias,
});

  @async
  AndroidSecureEncryptAuthResult authenticateBiometricSecureEncrypt({
    required String alias,
    required Map<String, String> requestForEncrypt,
    required String title,
    String? subTitle,
    required String description,
    required String negativeText,
    required bool confirmationRequired,
  });

  @async
  AndroidSecureDecryptAuthResult authenticateBiometricSecureDecrypt({
    required String alias,
    required String encodedIVKey,
    required Map<String, String> requestForDecrypt,
    required String title,
    String? subTitle,
    required String description,
    required String negativeText,
    required bool confirmationRequired,
  });
}
