import 'dart:io';

import 'package:flutter_feature_biometric_android/flutter_feature_biometric_android.dart';
import 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';

class FlutterFeatureBiometric implements FlutterFeatureBiometricPlatform {
  FlutterFeatureBiometric() {
    if (Platform.isAndroid) {
      FlutterFeatureBiometricPlatform.instance = FlutterFeatureBiometricAndroid();
    }
  }

  @override
  Future<void> authenticate({required FeatureBiometricType type, required String title, required String description, required String negativeText}) {
    return FlutterFeatureBiometricPlatform.instance.authenticate(type: type, title: title, description: description, negativeText: negativeText);
  }

  @override
  Future<bool> canAuthenticate(FeatureBiometricType type) {
    return FlutterFeatureBiometricPlatform.instance.canAuthenticate(type);
  }

  @override
  Future<bool> isDeviceSupportedBiometric() {
    return FlutterFeatureBiometricPlatform.instance.isDeviceSupportedBiometric();
  }

  @override
  Future<CheckBiometricStatus> checkBiometricStatus(FeatureBiometricType type) {
    return FlutterFeatureBiometricPlatform.instance.checkBiometricStatus(type);
  }
}
