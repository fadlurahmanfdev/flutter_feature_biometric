// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  kotlinOut: 'android/src/main/kotlin/com/fadlurahmanfdev/flutter_feature_biometric_android/Messages.kt',
  kotlinOptions: KotlinOptions(package: 'com.fadlurahmanfdev.flutter_feature_biometric_android'),
  copyrightHeader: 'pigeons/copyright.txt',
))
enum NativeBiometricStatus {
  success,
  noAvailable,
  unavailable,
  noneEnrolled,
  unknown,
}

enum NativeBiometricAuthenticator {
  weak,
  strong,
  deviceCredential,
}

enum NativeAuthResultStatus {
  success,
  canceled,
  failed,
  error,
  dialogClicked,
}

class NativeAuthDialogClickResult {
  int which;

  NativeAuthDialogClickResult({required this.which});
}

class NativeAuthFailure {
  String code;
  String? message;

  NativeAuthFailure({
    required this.code,
    this.message,
  });
}

class NativeAuthResult {
  NativeAuthResultStatus status;
  NativeAuthFailure? failure;
  NativeAuthDialogClickResult? dialogClickResult;

  NativeAuthResult({
    required this.status,
    this.failure,
    this.dialogClickResult,
  });
}

class NativeSecureEncryptAuthResult {
  NativeAuthResultStatus status;
  String? encodedIVKey;
  Map<String, String?>? encryptedResult;
  NativeAuthFailure? failure;
  NativeAuthDialogClickResult? dialogClickResult;

  NativeSecureEncryptAuthResult({
    required this.status,
    this.encodedIVKey,
    this.encryptedResult,
    this.failure,
    this.dialogClickResult,
  });
}

class NativeSecureDecryptAuthResult {
  NativeAuthResultStatus status;
  Map<String, String?>? decryptedResult;
  NativeAuthFailure? failure;
  NativeAuthDialogClickResult? dialogClickResult;

  NativeSecureDecryptAuthResult({
    required this.status,
    this.decryptedResult,
    this.failure,
    this.dialogClickResult,
  });
}

@HostApi()
abstract class FlutterFeatureBiometricApi {
  bool isDeviceSupportBiometric();

  NativeBiometricStatus checkAuthenticationStatus(NativeBiometricAuthenticator authenticator);

  bool canAuthenticate({
    required NativeBiometricAuthenticator authenticator,
  });

  @async
  NativeAuthResult authenticate({
    required NativeBiometricAuthenticator authenticator,
    required String title,
    required String description,
    required String negativeText,
  });

  @async
  NativeSecureEncryptAuthResult secureEncryptAuthenticate({
    required String alias,
    required Map<String, String> requestForEncrypt,
    required String title,
    required String description,
    required String negativeText,
  });

  @async
  NativeSecureDecryptAuthResult secureDecryptAuthenticate({
    required String alias,
    required String encodedIVKey,
    required Map<String, String> requestForDecrypt,
    required String title,
    required String description,
    required String negativeText,
  });
}
