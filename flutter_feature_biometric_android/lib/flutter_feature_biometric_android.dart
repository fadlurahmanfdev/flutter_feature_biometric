
import 'flutter_feature_biometric_android_platform_interface.dart';

class FlutterFeatureBiometricAndroid {
  Future<String?> getPlatformVersion() {
    return FlutterFeatureBiometricAndroidPlatform.instance.getPlatformVersion();
  }
}
