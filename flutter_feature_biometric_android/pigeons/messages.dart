// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  kotlinOut: 'android/src/main/kotlin/com/example/flutter_feature_biometric_android/Messages.kt',
  kotlinOptions: KotlinOptions(package: 'com.example.flutter_feature_biometric_android'),
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

@HostApi()
abstract class FlutterFeatureBiometricApi {
  bool deviceCanSupportBiometrics();
  NativeBiometricStatus checkBiometricStatus(NativeBiometricAuthenticator authenticator);
  void authenticate({required NativeBiometricAuthenticator authenticator, required String title, required String description, required String negativeText});
}