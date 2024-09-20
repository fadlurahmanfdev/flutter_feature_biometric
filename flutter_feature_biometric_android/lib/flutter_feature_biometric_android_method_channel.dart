import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_feature_biometric_android_platform_interface.dart';

/// An implementation of [FlutterFeatureBiometricAndroidPlatform] that uses method channels.
class MethodChannelFlutterFeatureBiometricAndroid extends FlutterFeatureBiometricAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_feature_biometric_android');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
