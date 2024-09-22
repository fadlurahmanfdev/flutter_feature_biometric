import 'package:pigeon/pigeon.dart';



@HostApi()
abstract class FlutterFeatureBiometricApi {
  bool isDeviceSupportBiometric();
}