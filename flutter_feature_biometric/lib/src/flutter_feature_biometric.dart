import 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';

class FlutterFeatureBiometric {
  Future<bool> isDeviceSupportBiometric() {
    return FlutterFeatureBiometricPlatform.instance.isDeviceSupportBiometric();
  }

  Future<BiometricStatus> checkAuthenticatorStatus(BiometricAuthenticatorType authenticator) {
    return FlutterFeatureBiometricPlatform.instance.checkAuthenticationTypeStatus(authenticator);
  }

  Future<bool> canSecureAuthenticate() {
    return FlutterFeatureBiometricPlatform.instance.canSecureAuthenticate();
  }

  Future<void> authenticate({
    required BiometricAuthenticatorType authenticator,
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

  Future<void> secureAuthenticate({
    required String title,
    required String description,
    required String negativeText,
  }) {
    return FlutterFeatureBiometricPlatform.instance.secureAuthenticate(
      title: title,
      description: description,
      negativeText: negativeText,
    );
  }
}
