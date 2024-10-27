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
enum NativeLAPolicy {
  biometric,
  deviceCredential,
}

enum NativeAuthResultStatus {
  success,
  biometricChanged,
  canceled,
}

class NativeAuthResult {
  NativeAuthResultStatus status;

  NativeAuthResult({required this.status});
}

@HostApi()
abstract class FlutterFeatureBiometricApi {
  bool isDeviceSupportBiometric();

  bool canAuthenticate(NativeLAPolicy policy);

  @async
  NativeAuthResult authenticate(NativeLAPolicy policy, String description);

  @async
  NativeAuthResult authenticateSecure(NativeLAPolicy policy, String key, String description);
}
