import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feature_biometric/flutter_feature_biometric.dart';
import 'package:flutter_feature_biometric_example/data/dto/model/feature_model.dart';
import 'package:flutter_feature_biometric_example/presentation/widget/feature_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Feature Crypto'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FlutterFeatureBiometric flutterFeatureBiometric;
  List<FeatureModel> features = [
    FeatureModel(
      title: 'Is Device Support Biometric',
      desc: 'Check whether device support biometric',
      key: 'IS_DEVICE_SUPPORT_BIOMETRIC',
    ),
    FeatureModel(
      title: 'Can Authenticate Biometric',
      desc: 'Check whether device can authenticate biometric',
      key: 'CAN_AUTHENTICATE_BIOMETRIC',
    ),
    FeatureModel(
      title: 'Standard Authenticate',
      desc: 'Standard Authenticate',
      key: 'STANDARD_BIOMETRIC_AUTHENTICATE',
    ),
    FeatureModel(
      title: 'Credential Authenticate',
      desc: 'Credential Authenticate',
      key: 'CREDENTIAL_AUTHENTICATE',
    ),
    FeatureModel(
      title: 'Can Secure Authenticate',
      desc: 'Check whether device can secure authenticate',
      key: 'CAN_SECURE_AUTHENTICATE',
    ),
    FeatureModel(
      title: 'Secure Encrypt Authenticate',
      desc: 'Secure Encrypt Authenticate',
      key: 'SECURE_ENCRYPT_AUTHENTICATE',
    ),
    FeatureModel(
      title: 'Secure Decrypt Authenticate',
      desc: 'Secure Decrypt Authenticate',
      key: 'SECURE_DECRYPT_AUTHENTICATE',
    ),
  ];

  @override
  void initState() {
    super.initState();
    flutterFeatureBiometric = FlutterFeatureBiometric();
  }

  late String encodedIVKey;
  Map<String, String> encryptedResult = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biometric')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: features.length,
        itemBuilder: (_, index) {
          final feature = features[index];
          return GestureDetector(
            onTap: () async {
              switch (feature.key) {
                case "IS_DEVICE_SUPPORT_BIOMETRIC":
                  final isSupportedBiometric = await flutterFeatureBiometric.isDeviceSupportBiometric();
                  print("${Platform.operatingSystem} - IS SUPPORT BIOMETRIC: $isSupportedBiometric");
                  break;
                case "CAN_AUTHENTICATE_BIOMETRIC":
                  final canAuthenticate =
                      await flutterFeatureBiometric.checkAuthenticatorStatus(BiometricAuthenticatorType.biometric);
                  print("${Platform.operatingSystem} - CAN AUTHENTICATE: $canAuthenticate");
                  break;
                case "STANDARD_BIOMETRIC_AUTHENTICATE":
                  flutterFeatureBiometric.authenticateBiometric(
                    title: "Title - Credential Authenticate",
                    description: "Description - Credential Authenticate",
                    confirmationRequired: true,
                    negativeText: "Batal",
                    onSuccessAuthenticate: () {
                      print("${Platform.operatingSystem} - Success authenticate credential");
                    },
                    onErrorAuthenticate: (code, message) {
                      print("${Platform.operatingSystem} - Error authenticate credential: $code - $message");
                    },
                    onCanceled: () {
                      print("${Platform.operatingSystem} - On Canceled");
                    },
                    onFailedAuthenticate: () {
                      print("${Platform.operatingSystem} - On Failed Authenticate");
                    },
                    onNegativeButtonClicked: (which) {
                      print("${Platform.operatingSystem} - onNegativeButtonClicked: $which");
                    },
                  );
                  break;
                case "CREDENTIAL_AUTHENTICATE":
                  flutterFeatureBiometric.authenticateDeviceCredential(
                    title: "Title - Credential Authenticate",
                    description: "Description - Credential Authenticate",
                    confirmationRequired: true,
                    negativeText: "Batal",
                    onSuccessAuthenticate: () {
                      print("${Platform.operatingSystem} - Success authenticate credential");
                    },
                    onErrorAuthenticate: (code, message) {
                      print("${Platform.operatingSystem} - Error authenticate credential: $code - $message");
                    },
                    onCanceled: () {
                      print("${Platform.operatingSystem} - On Canceled");
                    },
                    onFailedAuthenticate: () {
                      print("${Platform.operatingSystem} - On Failed Authenticate");
                    },
                    onNegativeButtonClicked: (which) {
                      print("${Platform.operatingSystem} - onNegativeButtonClicked: $which");
                    },
                  );
                  break;
                case "CAN_SECURE_AUTHENTICATE":
                  final canSecureAuthenticate = await flutterFeatureBiometric.canSecureAuthenticate();
                  print("${Platform.operatingSystem} - CAN SECURE AUTHENTICATE: $canSecureAuthenticate");
                  break;
                case "SECURE_ENCRYPT_AUTHENTICATE":
                  flutterFeatureBiometric.authenticateBiometricSecureEncrypt(
                    key: "flutterBiometricKey",
                    requestForEncrypt: {
                      "test": "P4ssw0rd",
                    },
                    title: "Secure Encrypt Authenticate",
                    description: "Secure Encrypt Authenticate",
                    negativeText: "Batal",
                    onSuccessAuthenticate: (state) {
                      if (state is SuccessAuthenticateEncryptAndroid) {
                        encodedIVKey = state.encodedIVKey;
                        state.encryptedResult.forEach((key, value) {
                          encryptedResult[key] = "$value";
                        });
                        print("${Platform.operatingSystem} - Success Encrypt Authenticate");
                        print("Encoded IV Key: $encodedIVKey");
                        print("Result: $encryptedResult");
                      }
                    },
                    onFailedAuthenticate: () {
                      print("${Platform.operatingSystem} - Failed Encrypt Authenticate");
                    },
                    onErrorAuthenticate: (code, message) {
                      print("${Platform.operatingSystem} - Error Encrypt Authenticate: $code - $message");
                    },
                    onNegativeButtonClicked: (which) {
                      print("${Platform.operatingSystem} - onNegativeButtonClicked: $which");
                    },
                  );
                  break;
                case "SECURE_DECRYPT_AUTHENTICATE":
                  flutterFeatureBiometric.authenticateBiometricSecureDecrypt(
                    key: "flutterBiometricKey",
                    encodedIVKey: "MbUhu6SsOk9vN8iJ/Td1lQ==",
                    requestForDecrypt: {"test": "xZqWsEIQLL/IaurzD5bZAQ=="},
                    title: "Secure Decrypt Authenticate",
                    description: "Secure Decrypt Authenticate",
                    negativeText: "Batal",
                    onSuccessAuthenticate: (state) {
                      print("${Platform.operatingSystem} - Success Decrypt Authenticate");
                      if (state is SuccessAuthenticateDecryptAndroid) {
                        print("Result: ${state.decryptedResult}");
                      }
                    },
                    onFailedAuthenticate: () {
                      print("${Platform.operatingSystem} - Failed Decrypt Authenticate");
                    },
                    onErrorAuthenticate: (code, message) {
                      print("${Platform.operatingSystem} - Error Decrypt Authenticate: $code - $message");
                    },
                    onNegativeButtonClicked: (which) {
                      print("${Platform.operatingSystem} - onNegativeButtonClicked: $which");
                    },
                    onCanceled: () {
                      print("onCanceled");
                    },
                  );
                  break;
              }
            },
            child: ItemFeatureWidget(feature: feature),
          );
        },
      ),
    );
  }
}
