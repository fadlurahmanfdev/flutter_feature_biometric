import 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';

class FlutterFeatureBiometric {
  Future<String?> getPlatformVersion() async {
    return 'tes';
  }

  Future<bool> isDeviceSupportBiometric() async {
    return FlutterFeatureBiometricPlatform.instance.isDeviceSupportedBiometric();
  }
}
