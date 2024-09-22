import 'dart:io';

import 'package:flutter_feature_biometric_android/flutter_feature_biometric_android.dart';
import 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';

class FlutterFeatureBiometric {
  FlutterFeatureBiometric() {
    if (Platform.isAndroid) {
      FlutterFeatureBiometricPlatform.instance = FlutterFeatureBiometricAndroid();
    }
  }

  Future<String?> getPlatformVersion() async {
    return 'tes';
  }

  Future<bool> isDeviceSupportBiometric() async {
    return FlutterFeatureBiometricPlatform.instance.isDeviceSupportedBiometric();
  }
}
