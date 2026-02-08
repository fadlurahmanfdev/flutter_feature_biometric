import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // MethodChannelMark platform = MethodChannelMark();
  // const MethodChannel channel = MethodChannel('mark');

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
