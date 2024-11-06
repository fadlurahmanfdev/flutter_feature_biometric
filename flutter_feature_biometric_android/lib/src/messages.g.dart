// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v22.5.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

PlatformException _createConnectionError(String channelName) {
  return PlatformException(
    code: 'channel-error',
    message: 'Unable to establish connection on channel: "$channelName".',
  );
}

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
  AndroidAuthenticationFailure({
    required this.code,
    this.message,
  });

  String code;

  String? message;

  Object encode() {
    return <Object?>[
      code,
      message,
    ];
  }

  static AndroidAuthenticationFailure decode(Object result) {
    result as List<Object?>;
    return AndroidAuthenticationFailure(
      code: result[0]! as String,
      message: result[1] as String?,
    );
  }
}

class AndroidAuthenticationResult {
  AndroidAuthenticationResult({
    required this.status,
    this.failure,
  });

  AndroidAuthenticationResultStatus status;

  AndroidAuthenticationFailure? failure;

  Object encode() {
    return <Object?>[
      status,
      failure,
    ];
  }

  static AndroidAuthenticationResult decode(Object result) {
    result as List<Object?>;
    return AndroidAuthenticationResult(
      status: result[0]! as AndroidAuthenticationResultStatus,
      failure: result[1] as AndroidAuthenticationFailure?,
    );
  }
}

class AndroidSecureEncryptAuthResult {
  AndroidSecureEncryptAuthResult({
    required this.status,
    this.encodedIVKey,
    this.encryptedResult,
    this.failure,
  });

  AndroidAuthenticationResultStatus status;

  String? encodedIVKey;

  Map<String, String?>? encryptedResult;

  AndroidAuthenticationFailure? failure;

  Object encode() {
    return <Object?>[
      status,
      encodedIVKey,
      encryptedResult,
      failure,
    ];
  }

  static AndroidSecureEncryptAuthResult decode(Object result) {
    result as List<Object?>;
    return AndroidSecureEncryptAuthResult(
      status: result[0]! as AndroidAuthenticationResultStatus,
      encodedIVKey: result[1] as String?,
      encryptedResult: (result[2] as Map<Object?, Object?>?)?.cast<String, String?>(),
      failure: result[3] as AndroidAuthenticationFailure?,
    );
  }
}

class AndroidSecureDecryptAuthResult {
  AndroidSecureDecryptAuthResult({
    required this.status,
    this.decryptedResult,
    this.failure,
  });

  AndroidAuthenticationResultStatus status;

  Map<String, String?>? decryptedResult;

  AndroidAuthenticationFailure? failure;

  Object encode() {
    return <Object?>[
      status,
      decryptedResult,
      failure,
    ];
  }

  static AndroidSecureDecryptAuthResult decode(Object result) {
    result as List<Object?>;
    return AndroidSecureDecryptAuthResult(
      status: result[0]! as AndroidAuthenticationResultStatus,
      decryptedResult: (result[1] as Map<Object?, Object?>?)?.cast<String, String?>(),
      failure: result[2] as AndroidAuthenticationFailure?,
    );
  }
}


class _PigeonCodec extends StandardMessageCodec {
  const _PigeonCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is int) {
      buffer.putUint8(4);
      buffer.putInt64(value);
    }    else if (value is AndroidAuthenticatorStatus) {
      buffer.putUint8(129);
      writeValue(buffer, value.index);
    }    else if (value is AndroidAuthenticatorType) {
      buffer.putUint8(130);
      writeValue(buffer, value.index);
    }    else if (value is AndroidAuthenticationResultStatus) {
      buffer.putUint8(131);
      writeValue(buffer, value.index);
    }    else if (value is AndroidAuthenticationFailure) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    }    else if (value is AndroidAuthenticationResult) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    }    else if (value is AndroidSecureEncryptAuthResult) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    }    else if (value is AndroidSecureDecryptAuthResult) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 129: 
        final int? value = readValue(buffer) as int?;
        return value == null ? null : AndroidAuthenticatorStatus.values[value];
      case 130: 
        final int? value = readValue(buffer) as int?;
        return value == null ? null : AndroidAuthenticatorType.values[value];
      case 131: 
        final int? value = readValue(buffer) as int?;
        return value == null ? null : AndroidAuthenticationResultStatus.values[value];
      case 132: 
        return AndroidAuthenticationFailure.decode(readValue(buffer)!);
      case 133: 
        return AndroidAuthenticationResult.decode(readValue(buffer)!);
      case 134: 
        return AndroidSecureEncryptAuthResult.decode(readValue(buffer)!);
      case 135: 
        return AndroidSecureDecryptAuthResult.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class FlutterFeatureBiometricApi {
  /// Constructor for [FlutterFeatureBiometricApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  FlutterFeatureBiometricApi({BinaryMessenger? binaryMessenger, String messageChannelSuffix = ''})
      : pigeonVar_binaryMessenger = binaryMessenger,
        pigeonVar_messageChannelSuffix = messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
  final BinaryMessenger? pigeonVar_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  final String pigeonVar_messageChannelSuffix;

  Future<void> deleteSecretKey(String alias) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.deleteSecretKey$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[alias]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<bool> isDeviceSupportFingerprint() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.isDeviceSupportFingerprint$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as bool?)!;
    }
  }

  Future<bool> isDeviceSupportFaceAuth() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.isDeviceSupportFaceAuth$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as bool?)!;
    }
  }

  Future<bool> isDeviceSupportBiometric() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.isDeviceSupportBiometric$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as bool?)!;
    }
  }

  Future<bool> isFingerprintEnrolled() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.isFingerprintEnrolled$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as bool?)!;
    }
  }

  Future<bool> isDeviceCredentialEnrolled() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.isDeviceCredentialEnrolled$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as bool?)!;
    }
  }

  Future<AndroidAuthenticatorStatus> checkAuthenticatorStatus(AndroidAuthenticatorType androidAuthenticatorType) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.checkAuthenticatorStatus$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[androidAuthenticatorType]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as AndroidAuthenticatorStatus?)!;
    }
  }

  Future<AndroidAuthenticatorStatus> checkSecureAuthenticatorStatus() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.checkSecureAuthenticatorStatus$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as AndroidAuthenticatorStatus?)!;
    }
  }

  Future<bool> canAuthenticate({required AndroidAuthenticatorType androidAuthenticatorType}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.canAuthenticate$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[androidAuthenticatorType]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as bool?)!;
    }
  }

  Future<AndroidAuthenticationResult> authenticateDeviceCredential({required String title, String? subTitle, required String description, required String negativeText, required bool confirmationRequired,}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.authenticateDeviceCredential$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[title, subTitle, description, negativeText, confirmationRequired]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as AndroidAuthenticationResult?)!;
    }
  }

  Future<AndroidAuthenticationResult> authenticateBiometric({required String title, String? subTitle, required String description, required String negativeText, required bool confirmationRequired,}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.authenticateBiometric$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[title, subTitle, description, negativeText, confirmationRequired]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as AndroidAuthenticationResult?)!;
    }
  }

  Future<bool> isBiometricChanged({required String alias}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.isBiometricChanged$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[alias]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as bool?)!;
    }
  }

  Future<AndroidSecureEncryptAuthResult> authenticateBiometricSecureEncrypt({required String alias, required Map<String, String> requestForEncrypt, required String title, String? subTitle, required String description, required String negativeText, required bool confirmationRequired,}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.authenticateBiometricSecureEncrypt$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[alias, requestForEncrypt, title, subTitle, description, negativeText, confirmationRequired]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as AndroidSecureEncryptAuthResult?)!;
    }
  }

  Future<AndroidSecureDecryptAuthResult> authenticateBiometricSecureDecrypt({required String alias, required String encodedIVKey, required Map<String, String> requestForDecrypt, required String title, String? subTitle, required String description, required String negativeText, required bool confirmationRequired,}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.authenticateBiometricSecureDecrypt$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[alias, encodedIVKey, requestForDecrypt, title, subTitle, description, negativeText, confirmationRequired]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as AndroidSecureDecryptAuthResult?)!;
    }
  }
}
