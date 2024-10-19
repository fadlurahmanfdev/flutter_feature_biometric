import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_feature_biometric_ios/flutter_feature_biometric_ios.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockFlutterFeatureBiometricIosPlatform
//     with MockPlatformInterfaceMixin
//     implements FlutterFeatureBiometricIosPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

void main() {
  // final FlutterFeatureBiometricIosPlatform initialPlatform = FlutterFeatureBiometricIosPlatform.instance;

  // test('$MethodChannelFlutterFeatureBiometricIos is the default instance', () {
  //   expect(initialPlatform, isInstanceOf<MethodChannelFlutterFeatureBiometricIos>());
  // });

  test('getPlatformVersion', () async {
    // FlutterFeatureBiometricIos flutterFeatureBiometricIosPlugin = FlutterFeatureBiometricIos();
    // MockFlutterFeatureBiometricIosPlatform fakePlatform = MockFlutterFeatureBiometricIosPlatform();
    // FlutterFeatureBiometricIosPlatform.instance = fakePlatform;
    //
    // expect(await flutterFeatureBiometricIosPlugin.getPlatformVersion(), '42');
  });
}
