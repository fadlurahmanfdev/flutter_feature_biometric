import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_feature_biometric_android_method_channel.dart';

abstract class FlutterFeatureBiometricAndroidPlatform extends PlatformInterface {
  /// Constructs a FlutterFeatureBiometricAndroidPlatform.
  FlutterFeatureBiometricAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterFeatureBiometricAndroidPlatform _instance = MethodChannelFlutterFeatureBiometricAndroid();

  /// The default instance of [FlutterFeatureBiometricAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterFeatureBiometricAndroid].
  static FlutterFeatureBiometricAndroidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterFeatureBiometricAndroidPlatform] when
  /// they register themselves.
  static set instance(FlutterFeatureBiometricAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
