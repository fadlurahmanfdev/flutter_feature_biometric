import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_feature_biometric/flutter_feature_biometric.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterFeatureBiometricPlugin = FlutterFeatureBiometric();

  bool isSupported = false;
  @override
  void initState() {
    super.initState();
    test();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> test() async {

    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      isSupported = await _flutterFeatureBiometricPlugin.isDeviceSupportedBiometric();
      print("masuk sini2");
    } on PlatformException catch(e) {
      log("failed: $e");
      isSupported = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Is Device Support Biometric: $isSupported'),
        ),
      ),
    );
  }
}
