import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_feature_biometric_method_channel.dart';

abstract class FlutterFeatureBiometricPlatform extends PlatformInterface {
  /// Constructs a FlutterFeatureBiometricPlatform.
  FlutterFeatureBiometricPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterFeatureBiometricPlatform _instance = MethodChannelFlutterFeatureBiometric();

  /// The default instance of [FlutterFeatureBiometricPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterFeatureBiometric].
  static FlutterFeatureBiometricPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterFeatureBiometricPlatform] when
  /// they register themselves.
  static set instance(FlutterFeatureBiometricPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
