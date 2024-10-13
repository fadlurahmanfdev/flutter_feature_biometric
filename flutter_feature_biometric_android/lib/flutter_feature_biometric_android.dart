import 'package:flutter_feature_biometric_android/src/messages.g.dart';
import 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';


class FlutterFeatureBiometricAndroid extends FlutterFeatureBiometricPlatform {
  final _hostApi = HostFeatureBiometricApi();

  @override
  Future<bool> isDeviceSupportedBiometric() async {
    return (await _hostApi.haveFeatureBiometric()) || (await _hostApi.haveFaceDetection());
  }

  @override
  Future<bool> canAuthenticate(FeatureBiometricType type) {
    final nativeType = switch (type) {
      FeatureBiometricType.weak => NativeBiometricType.weak,
      FeatureBiometricType.strong => NativeBiometricType.strong,
      FeatureBiometricType.deviceCredential => NativeBiometricType.deviceCredential,
    };
    return _hostApi.canAuthenticate(nativeType);
  }

  @override
  Future<CheckBiometricStatus> checkBiometricStatus(FeatureBiometricType type) async {
    final nativeType = switch (type) {
      FeatureBiometricType.weak => NativeBiometricType.weak,
      FeatureBiometricType.strong => NativeBiometricType.strong,
      FeatureBiometricType.deviceCredential => NativeBiometricType.deviceCredential,
    };

    final nativeStatus = await _hostApi.checkBiometricStatus(nativeType);
    switch (nativeStatus) {
      case NativeAndroidBiometricStatus.success:
        return CheckBiometricStatus.success;
      case NativeAndroidBiometricStatus.noBiometricAvailable:
        return CheckBiometricStatus.noBiometricAvailable;
      case NativeAndroidBiometricStatus.unavailable:
        return CheckBiometricStatus.unavailable;
      case NativeAndroidBiometricStatus.noneEnrolled:
        return CheckBiometricStatus.noneEnrolled;
      case NativeAndroidBiometricStatus.unknown:
        return CheckBiometricStatus.unknown;
    }
  }

  @override
  Future<void> authenticate({
    required FeatureBiometricType type,
    required String title,
    required String description,
    required String negativeText,
  }) async {
    final nativeType = switch (type) {
      FeatureBiometricType.weak => NativeBiometricType.weak,
      FeatureBiometricType.strong => NativeBiometricType.strong,
      FeatureBiometricType.deviceCredential => NativeBiometricType.deviceCredential,
    };
    final res = await _hostApi.authenticate(
      type: nativeType,
      title: title,
      description: description,
      negativeText: negativeText,
    );
    print("masuk result: $res");
  }
}
