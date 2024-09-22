import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_feature_biometric_platform_interface.dart';

/// An implementation of [FlutterFeatureBiometricPlatform] that uses method channels.
class MethodChannelFlutterFeatureBiometric extends FlutterFeatureBiometricPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_feature_biometric');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
