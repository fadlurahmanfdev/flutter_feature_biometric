package com.fadlurahmanfdev.flutter_feature_biometric_android

class FeatureBiometricPlugin : FlutterFeatureBiometricApi {
    override fun isDeviceSupported(): Boolean {
        return true
    }
}