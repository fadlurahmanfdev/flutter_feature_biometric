import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_feature_biometric_android/flutter_feature_biometric_android.dart';
import 'package:flutter_feature_biometric_android/flutter_feature_biometric_android_platform_interface.dart';
import 'package:flutter_feature_biometric_android/flutter_feature_biometric_android_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterFeatureBiometricAndroidPlatform
    with MockPlatformInterfaceMixin
    implements FlutterFeatureBiometricAndroidPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterFeatureBiometricAndroidPlatform initialPlatform = FlutterFeatureBiometricAndroidPlatform.instance;

  test('$MethodChannelFlutterFeatureBiometricAndroid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterFeatureBiometricAndroid>());
  });

  test('getPlatformVersion', () async {
    FlutterFeatureBiometricAndroid flutterFeatureBiometricAndroidPlugin = FlutterFeatureBiometricAndroid();
    MockFlutterFeatureBiometricAndroidPlatform fakePlatform = MockFlutterFeatureBiometricAndroidPlatform();
    FlutterFeatureBiometricAndroidPlatform.instance = fakePlatform;

    // expect(await flutterFeatureBiometricAndroidPlugin.getPlatformVersion(), '42');
  });
}
