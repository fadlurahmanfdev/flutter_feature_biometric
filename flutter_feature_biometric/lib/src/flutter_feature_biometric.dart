import 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';

class FlutterFeatureBiometric {
  Future<bool> deviceSupportsBiometrics() {
    return FlutterFeatureBiometricPlatform.instance.deviceSupportsBiometrics();
  }
}
