
import 'package:flutter_feature_biometric_android/src/messages.g.dart';
import 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';

class FlutterFeatureBiometricAndroid extends FlutterFeatureBiometricPlatform {

  final _api = FlutterFeatureBiometricApi();

  @override
  Future<bool> isDeviceSupportBiometric() {
    return _api.isDeviceSupported();
  }
}
