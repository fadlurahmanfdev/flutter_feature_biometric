import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_feature_biometric/flutter_feature_biometric.dart';
import 'package:flutter_feature_biometric/flutter_feature_biometric_platform_interface.dart';
import 'package:flutter_feature_biometric/flutter_feature_biometric_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterFeatureBiometricPlatform
    with MockPlatformInterfaceMixin
    implements FlutterFeatureBiometricPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterFeatureBiometricPlatform initialPlatform = FlutterFeatureBiometricPlatform.instance;

  test('$MethodChannelFlutterFeatureBiometric is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterFeatureBiometric>());
  });

  test('getPlatformVersion', () async {
    FlutterFeatureBiometric flutterFeatureBiometricPlugin = FlutterFeatureBiometric();
    MockFlutterFeatureBiometricPlatform fakePlatform = MockFlutterFeatureBiometricPlatform();
    FlutterFeatureBiometricPlatform.instance = fakePlatform;

    expect(await flutterFeatureBiometricPlugin.getPlatformVersion(), '42');
  });
}
