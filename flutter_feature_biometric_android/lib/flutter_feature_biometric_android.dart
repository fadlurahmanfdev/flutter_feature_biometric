import 'package:flutter_feature_biometric_android/src/messages.g.dart';
import 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';

import 'flutter_feature_biometric_android_platform_interface.dart';

class FlutterFeatureBiometricAndroid extends FlutterFeatureBiometricPlatform {
  final _hostApi = HostFeatureBiometricApi();

  Future<String?> getPlatformVersion() {
    return FlutterFeatureBiometricAndroidPlatform.instance.getPlatformVersion();
  }

  @override
  Future<bool> isDeviceSupportedBiometric() async {
    // return _api.isDeviceSupportBiometric();
    return true;
  }

  @override
  Future<bool> canAuthenticate() async {
    // return _api.canAuthenticate();
    return true;
  }

  @override
  Future<CanAuthenticateType> canAuthenticateWithReason() async {
    // final check = await _api.canAuthenticateWithReason();
    // return CanAuthenticateType.success;
    return CanAuthenticateType.success;
  }
}

class NativeFeatureBiometricCallbackImpl implements NativeFeatureBiometricCallback {
  NativeFeatureBiometricCallbackImpl() {
    NativeFeatureBiometricCallback.setUp(this);
  }

  @override
  Future<int> onSuccessAuthenticate() {
    // TODO: implement onSuccessAuthenticate
    throw UnimplementedError();
  }

}