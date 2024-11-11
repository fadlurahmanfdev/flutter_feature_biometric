// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  swiftOut: 'ios/Classes/Messages.swift',
  swiftOptions: SwiftOptions(),
  copyrightHeader: 'pigeons/copyright.txt',
))
enum IOSLAPolicy {
  biometric,
  deviceCredential,
}

enum IOSAuthenticationResultStatus {
  success,
  biometricChanged,
  canceled,
}

class IOSAuthenticationResult {
  IOSAuthenticationResultStatus status;
  String? encodedDomainState;

  IOSAuthenticationResult({
    required this.status,
    this.encodedDomainState,
  });
}

@HostApi()
abstract class FlutterFeatureBiometricApi {
  bool isDeviceSupportBiometric();

  bool canAuthenticate({required IOSLAPolicy laPolicy});

  @async
  IOSAuthenticationResult authenticate({required IOSLAPolicy laPolicy, required String description});

  bool isBiometricChanged({required String alias, required String encodedDomainState});

  @async
  IOSAuthenticationResult authenticateSecureEncrypt({
    required IOSLAPolicy laPolicy,
    required String alias,
    required String description,
  });

  @async
  IOSAuthenticationResult authenticateSecureDecrypt({
    required IOSLAPolicy laPolicy,
    required String encodedDomainState,
    required String alias,
    required String description,
  });
}
