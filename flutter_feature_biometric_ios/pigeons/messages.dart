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

  IOSAuthenticationResult({required this.status});
}

@HostApi()
abstract class FlutterFeatureBiometricApi {
  bool isDeviceSupportBiometric();

  bool canAuthenticate(IOSLAPolicy laPolicy);

  @async
  IOSAuthenticationResult authenticate(IOSLAPolicy policy, String description);

  @async
  IOSAuthenticationResult authenticateSecure(IOSLAPolicy policy, String key, String description);
}
