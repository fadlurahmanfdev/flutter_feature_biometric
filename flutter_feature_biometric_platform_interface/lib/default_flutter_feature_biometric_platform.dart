import 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';

class DefaultFlutterFeatureBiometricPlatform extends FlutterFeatureBiometricPlatform {
  @override
  Future<bool> isDeviceSupportBiometric() async {
    return true;
  }

}