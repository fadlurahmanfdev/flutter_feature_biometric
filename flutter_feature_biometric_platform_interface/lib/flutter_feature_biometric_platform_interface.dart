library flutter_feature_biometric_platform_interface;

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class FlutterFeatureBiometricPlatform extends PlatformInterface {
  FlutterFeatureBiometricPlatform() : super(token: _token);

  static final Object _token = Object();

  Future<bool> isDeviceSupportBiometric();
}
