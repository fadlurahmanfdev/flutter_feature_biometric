import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    kotlinOut: 'android/src/main/kotlin/com/fadlurahmanfdev/flutter_feature_biometric_android/Messages.kt',
    kotlinOptions: KotlinOptions(
      package: 'com.fadlurahmanfdev.flutter_feature_biometric_android',
    ),
  ),
)
@HostApi()
abstract class FlutterFeatureBiometricApi {
  bool isDeviceSupported();
}
