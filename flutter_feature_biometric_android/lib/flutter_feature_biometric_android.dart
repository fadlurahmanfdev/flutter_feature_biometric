import 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';

import 'flutter_feature_biometric_android_platform_interface.dart';

class FlutterFeatureBiometricAndroid extends FlutterFeatureBiometricPlatform {
  Future<String?> getPlatformVersion() {
    return FlutterFeatureBiometricAndroidPlatform.instance.getPlatformVersion();
  }

  @override
  Future<bool> isDeviceSupportedBiometric() async {
    return true;
  }
}
