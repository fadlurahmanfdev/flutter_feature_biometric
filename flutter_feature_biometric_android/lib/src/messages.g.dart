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
  failed,
  error,
  dialogClicked,
}

class NativeAuthDialogClickResult {
  NativeAuthDialogClickResult({
    required this.which,
  });

  int which;

  Object encode() {
    return <Object?>[
      which,
    ];
  }

  static NativeAuthDialogClickResult decode(Object result) {
    result as List<Object?>;
    return NativeAuthDialogClickResult(
      which: result[0]! as int,
    );
  }
}

class NativeAuthFailure {
  NativeAuthFailure({
    required this.code,
    required this.message,
  });

  String code;

  String message;

  Object encode() {
    return <Object?>[
      code,
      message,
    ];
  }

  static NativeAuthFailure decode(Object result) {
    result as List<Object?>;
    return NativeAuthFailure(
      code: result[0]! as String,
      message: result[1]! as String,
    );
  }
}

class NativeAuthResult {
  NativeAuthResult({
    required this.status,
    this.dialogClickResult,
  });

  NativeAuthResultStatus status;

  NativeAuthDialogClickResult? dialogClickResult;

  Object encode() {
    return <Object?>[
      status,
      dialogClickResult,
    ];
  }

  static NativeAuthResult decode(Object result) {
    result as List<Object?>;
    return NativeAuthResult(
      status: result[0]! as NativeAuthResultStatus,
      dialogClickResult: result[1] as NativeAuthDialogClickResult?,
    );
  }
}

class NativeSecureEncryptAuthResult {
  NativeSecureEncryptAuthResult({
    required this.status,
    this.encodedIVKey,
    this.encryptedResult,
    this.failure,
    this.dialogClickResult,
  });

  NativeAuthResultStatus status;

  String? encodedIVKey;

  Map<String, String?>? encryptedResult;

  NativeAuthFailure? failure;

  NativeAuthDialogClickResult? dialogClickResult;

  Object encode() {
    return <Object?>[
      status,
      encodedIVKey,
      encryptedResult,
      failure,
      dialogClickResult,
    ];
  }

  static NativeSecureEncryptAuthResult decode(Object result) {
    result as List<Object?>;
    return NativeSecureEncryptAuthResult(
      status: result[0]! as NativeAuthResultStatus,
      encodedIVKey: result[1] as String?,
      encryptedResult: (result[2] as Map<Object?, Object?>?)?.cast<String, String?>(),
      failure: result[3] as NativeAuthFailure?,
      dialogClickResult: result[4] as NativeAuthDialogClickResult?,
    );
  }
}

class NativeSecureDecryptAuthResult {
  NativeSecureDecryptAuthResult({
    required this.status,
    this.decryptedResult,
    this.failure,
    this.dialogClickResult,
  });

  NativeAuthResultStatus status;

  Map<String, String?>? decryptedResult;

  NativeAuthFailure? failure;

  NativeAuthDialogClickResult? dialogClickResult;

  Object encode() {
    return <Object?>[
      status,
      decryptedResult,
      failure,
      dialogClickResult,
    ];
  }

  static NativeSecureDecryptAuthResult decode(Object result) {
    result as List<Object?>;
    return NativeSecureDecryptAuthResult(
      status: result[0]! as NativeAuthResultStatus,
      decryptedResult: (result[1] as Map<Object?, Object?>?)?.cast<String, String?>(),
      failure: result[2] as NativeAuthFailure?,
      dialogClickResult: result[3] as NativeAuthDialogClickResult?,
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
    }    else if (value is NativeBiometricStatus) {
      buffer.putUint8(129);
      writeValue(buffer, value.index);
    }    else if (value is NativeBiometricAuthenticator) {
      buffer.putUint8(130);
      writeValue(buffer, value.index);
    }    else if (value is NativeAuthResultStatus) {
      buffer.putUint8(131);
      writeValue(buffer, value.index);
    }    else if (value is NativeAuthDialogClickResult) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    }    else if (value is NativeAuthFailure) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    }    else if (value is NativeAuthResult) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    }    else if (value is NativeSecureEncryptAuthResult) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    }    else if (value is NativeSecureDecryptAuthResult) {
      buffer.putUint8(136);
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
        return value == null ? null : NativeBiometricStatus.values[value];
      case 130: 
        final int? value = readValue(buffer) as int?;
        return value == null ? null : NativeBiometricAuthenticator.values[value];
      case 131: 
        final int? value = readValue(buffer) as int?;
        return value == null ? null : NativeAuthResultStatus.values[value];
      case 132: 
        return NativeAuthDialogClickResult.decode(readValue(buffer)!);
      case 133: 
        return NativeAuthFailure.decode(readValue(buffer)!);
      case 134: 
        return NativeAuthResult.decode(readValue(buffer)!);
      case 135: 
        return NativeSecureEncryptAuthResult.decode(readValue(buffer)!);
      case 136: 
        return NativeSecureDecryptAuthResult.decode(readValue(buffer)!);
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

  Future<NativeBiometricStatus> checkAuthenticationStatus(NativeBiometricAuthenticator authenticator) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.checkAuthenticationStatus$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[authenticator]) as List<Object?>?;
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
      return (pigeonVar_replyList[0] as NativeBiometricStatus?)!;
    }
  }

  Future<bool> canAuthenticate({required NativeBiometricAuthenticator authenticator}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.canAuthenticate$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[authenticator]) as List<Object?>?;
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

  Future<NativeAuthResult> authenticate({required NativeBiometricAuthenticator authenticator, required String title, required String description, required String negativeText,}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.authenticate$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[authenticator, title, description, negativeText]) as List<Object?>?;
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
      return (pigeonVar_replyList[0] as NativeAuthResult?)!;
    }
  }

  Future<NativeSecureEncryptAuthResult> secureEncryptAuthenticate({required String alias, required Map<String, String> requestForEncrypt, required String title, required String description, required String negativeText,}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.secureEncryptAuthenticate$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[alias, requestForEncrypt, title, description, negativeText]) as List<Object?>?;
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
      return (pigeonVar_replyList[0] as NativeSecureEncryptAuthResult?)!;
    }
  }

  Future<NativeSecureDecryptAuthResult> secureDecryptAuthenticate({required String alias, required String encodedIVKey, required Map<String, String> requestForDecrypt, required String title, required String description, required String negativeText,}) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.secureDecryptAuthenticate$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[alias, encodedIVKey, requestForDecrypt, title, description, negativeText]) as List<Object?>?;
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
      return (pigeonVar_replyList[0] as NativeSecureDecryptAuthResult?)!;
    }
  }
}
