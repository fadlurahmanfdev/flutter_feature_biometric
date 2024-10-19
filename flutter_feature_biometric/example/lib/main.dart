import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_feature_biometric/flutter_feature_biometric.dart';
import 'package:flutter_feature_biometric_platform_interface/flutter_feature_biometric_platform_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _deviceSupportsBiometrics = false;
  final _flutterFeatureBiometricPlugin = FlutterFeatureBiometric();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool deviceSupportsBiometrics;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      deviceSupportsBiometrics = await _flutterFeatureBiometricPlugin.isDeviceSupportBiometric();
      // _flutterFeatureBiometricPlugin.checkAuthenticatorStatus(BiometricAuthenticatorType.deviceCredential).then((value) {
      //   print("masuk sini -> $value");
      // });
    } on PlatformException {
      deviceSupportsBiometrics = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _deviceSupportsBiometrics = deviceSupportsBiometrics;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Center(
                child: Text('deviceSupportsBiometrics: $_deviceSupportsBiometrics\n'),
              ),
              ElevatedButton(
                onPressed: () async {
                  _flutterFeatureBiometricPlugin.authenticate(
                    authenticator: BiometricAuthenticatorType.deviceCredential,
                    title: "Flutter Title",
                    description: "Flutter Desc",
                    negativeText: "Flutter Neg Text",
                  ).then((value){});
                },
                child: const Text('Authenticate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
