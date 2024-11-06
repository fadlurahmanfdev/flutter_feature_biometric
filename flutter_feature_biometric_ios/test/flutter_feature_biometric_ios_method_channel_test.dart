import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // MethodChannelFlutterFeatureBiometricIos platform = MethodChannelFlutterFeatureBiometricIos();
  // const MethodChannel channel = MethodChannel('flutter_feature_biometric_ios');

  setUp(() {
    // TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
    //   channel,
    //   (MethodCall methodCall) async {
    //     return '42';
    //   },
    // );
  });

  tearDown(() {
    // TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    // expect(await platform.getPlatformVersion(), '42');
  });
}
