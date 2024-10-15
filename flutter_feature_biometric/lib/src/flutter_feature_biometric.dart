import 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';

class FlutterFeatureBiometric {
  Future<bool> deviceSupportsBiometrics() {
    return FlutterFeatureBiometricPlatform.instance.deviceSupportsBiometrics();
  }

  Future<BiometricStatus> checkBiometricStatus(BiometricAuthenticator authenticator) {
    return FlutterFeatureBiometricPlatform.instance.checkBiometricStatus(authenticator);
  }

  Future<void> authenticate({
    required BiometricAuthenticator authenticator,
    required String title,
    required String description,
    required String negativeText,
  }) {
    return FlutterFeatureBiometricPlatform.instance.authenticate(
      authenticator: authenticator,
      title: title,
      description: description,
      negativeText: negativeText,
    );
  }
}
