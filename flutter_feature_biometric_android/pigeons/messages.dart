import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    kotlinOut: 'android/src/main/kotlin/com/fadlurahmanfdev/flutter_feature_biometric_android/Messages.kt',
    kotlinOptions: KotlinOptions(package: 'com.fadlurahmanfdev.flutter_feature_biometric_android'),
    copyrightHeader: 'pigeons/copyright.txt',
  ),
)
enum NativeBiometricType { weak, strong, deviceCredential }

enum NativeAndroidBiometricStatus {
  success,
  noBiometricAvailable,
  unavailable,
  noneEnrolled,
  unknown,
}

@FlutterApi()
abstract class NativeFeatureBiometricCallback {
  void onSuccessAuthenticate();
}

@HostApi()
abstract class HostFeatureBiometricApi {
  bool haveFeatureBiometric();

  bool haveFaceDetection();

  bool canAuthenticate(NativeBiometricType authenticator);

  NativeAndroidBiometricStatus checkBiometricStatus(NativeBiometricType type);

  void authenticate({
    required NativeBiometricType type,
    required String title,
    required String description,
    required String negativeText,
  });
}
