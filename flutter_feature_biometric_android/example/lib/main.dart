import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_feature_biometric_android/flutter_feature_biometric_android.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSupportedBiometric = false;
  final _flutterFeatureBiometricAndroidPlugin = FlutterFeatureBiometricAndroid();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool isSupportedBiometric;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      isSupportedBiometric =
          await _flutterFeatureBiometricAndroidPlugin.isDeviceSupportedBiometric();
    } on PlatformException {
      isSupportedBiometric = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _isSupportedBiometric = isSupportedBiometric;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Android Plugin example app'),
        ),
        body: Center(
          child: Text('Is supported biometric: $_isSupportedBiometric\n'),
        ),
      ),
    );
  }
}
