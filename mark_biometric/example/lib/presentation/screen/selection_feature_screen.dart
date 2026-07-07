import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mark_biometric/mark_biometric.dart';
import 'package:mark_example/data/dto/model/feature_model.dart';
import 'package:mark_example/presentation/widget/feature_widget.dart';

class SelectionFeatureScreen extends StatefulWidget {
  const SelectionFeatureScreen({super.key});

  @override
  State<SelectionFeatureScreen> createState() => _SelectionFeatureScreenState();
}

class _SelectionFeatureScreenState extends State<SelectionFeatureScreen> {
  static const String _featureIsDeviceSupportBiometric = 'IS_DEVICE_SUPPORT_BIOMETRIC';
  static const String _featureCanAuthenticateBiometric = 'CAN_AUTHENTICATE_BIOMETRIC';
  static const String _featureStandardBiometricAuthenticate = 'STANDARD_BIOMETRIC_AUTHENTICATE';
  static const String _featureCredentialAuthenticate = 'CREDENTIAL_AUTHENTICATE';
  static const String _featureCanSecureAuthenticate = 'CAN_SECURE_AUTHENTICATE';
  static const String _featureIsBiometricChanged = 'IS_BIOMETRIC_CHANGED';
  static const String _featureSecureEncryptAuthenticate = 'SECURE_ENCRYPT_AUTHENTICATE';
  static const String _featureSecureDecryptAuthenticate = 'SECURE_DECRYPT_AUTHENTICATE';

  final MarkBiometric _markBiometric = MarkBiometric();
  final List<String> _resultHistory = <String>[];

  final List<FeatureModel> _features = <FeatureModel>[
    FeatureModel(
      title: 'Is Device Support Biometric',
      desc: 'Check whether device supports biometric capability',
      key: _featureIsDeviceSupportBiometric,
      icon: Icons.fingerprint_rounded,
    ),
    FeatureModel(
      title: 'Can Authenticate Biometric',
      desc: 'Check biometric authenticator status',
      key: _featureCanAuthenticateBiometric,
      icon: Icons.shield_rounded,
    ),
    FeatureModel(
      title: 'Standard Authenticate',
      desc: 'Run biometric authentication prompt',
      key: _featureStandardBiometricAuthenticate,
      icon: Icons.lock_open_rounded,
    ),
    FeatureModel(
      title: 'Credential Authenticate',
      desc: 'Run device credential authentication prompt',
      key: _featureCredentialAuthenticate,
      icon: Icons.password_rounded,
    ),
    FeatureModel(
      title: 'Can Secure Authenticate',
      desc: 'Check secure biometric authentication support',
      key: _featureCanSecureAuthenticate,
      icon: Icons.verified_user_rounded,
    ),
    FeatureModel(
      title: 'Check Whether Biometric Changed',
      desc: 'Check whether enrolled biometric data changed',
      key: _featureIsBiometricChanged,
      icon: Icons.change_circle_rounded,
    ),
    FeatureModel(
      title: 'Secure Encrypt Authenticate',
      desc: 'Authenticate and encrypt sample data',
      key: _featureSecureEncryptAuthenticate,
      icon: Icons.lock_rounded,
    ),
    FeatureModel(
      title: 'Secure Decrypt Authenticate',
      desc: 'Authenticate and decrypt encrypted sample data',
      key: _featureSecureDecryptAuthenticate,
      icon: Icons.lock_reset_rounded,
    ),
  ];

  String? _encodedKey;
  final Map<String, String> _encryptedResult = <String, String>{};
  String _latestResult = 'Tap any feature item to simulate the flow.';

  void _setResult(String message) {
    if (!mounted) return;
    setState(() {
      _latestResult = message;
    });
  }

  Future<void> _runFeature(FeatureModel feature) async {
    try {
      switch (feature.key) {
        case _featureIsDeviceSupportBiometric:
          final bool isSupportedBiometric = await _markBiometric.isDeviceSupportBiometric();
          _setResult('${Platform.operatingSystem}: biometric support = $isSupportedBiometric');
          break;
        case _featureCanAuthenticateBiometric:
          final MarkAuthenticatorStatus canAuthenticate = await _markBiometric.checkAuthenticatorStatus(
            MarkAuthenticatorType.biometric,
          );
          _setResult('${Platform.operatingSystem}: biometric status = $canAuthenticate');
          break;
        case _featureStandardBiometricAuthenticate:
          await _markBiometric.authenticate(
            authenticatorType: MarkAuthenticatorType.biometric,
            title: 'Title - Biometric Authenticate',
            description: 'Description - Biometric Authenticate',
            confirmationRequired: true,
            negativeText: 'Batal',
            onSuccessAuthenticate: () {
              _setResult('${Platform.operatingSystem}: success authenticate biometric');
            },
            onErrorAuthenticate: (String code, String? message) {
              _setResult('${Platform.operatingSystem}: error authenticate biometric: $code - $message');
            },
            onCanceled: () {
              _setResult('${Platform.operatingSystem}: authenticate biometric canceled');
            },
            onFailedAuthenticate: () {
              _setResult('${Platform.operatingSystem}: authenticate biometric failed');
            },
            onNegativeButtonClicked: (int which) {
              _setResult('${Platform.operatingSystem}: biometric negative button clicked: $which');
            },
          );
          break;
        case _featureCredentialAuthenticate:
          await _markBiometric.authenticate(
            authenticatorType: MarkAuthenticatorType.deviceCredential,
            title: 'Title - Credential Authenticate',
            description: 'Description - Credential Authenticate',
            confirmationRequired: true,
            negativeText: 'Batal',
            onSuccessAuthenticate: () {
              _setResult('${Platform.operatingSystem}: success authenticate device credential');
            },
            onErrorAuthenticate: (String code, String? message) {
              _setResult('${Platform.operatingSystem}: error authenticate credential: $code - $message');
            },
            onCanceled: () {
              _setResult('${Platform.operatingSystem}: authenticate credential canceled');
            },
            onFailedAuthenticate: () {
              _setResult('${Platform.operatingSystem}: authenticate credential failed');
            },
            onNegativeButtonClicked: (int which) {
              _setResult('${Platform.operatingSystem}: credential negative button clicked: $which');
            },
          );
          break;
        case _featureCanSecureAuthenticate:
          final bool canSecureAuthenticate = await _markBiometric.canSecureAuthenticate();
          _setResult('${Platform.operatingSystem}: secure authenticate support = $canSecureAuthenticate');
          break;
        case _featureIsBiometricChanged:
          final String? encodedKey = _encodedKey;
          if (encodedKey == null || encodedKey.isEmpty) {
            _setResult('Run "Secure Encrypt Authenticate" first to generate encoded key.');
            return;
          }
          final bool isBiometricChanged = await _markBiometric.isBiometricChanged(
            key: 'flutterBiometricKey',
            encodedKey: encodedKey,
          );
          _setResult('${Platform.operatingSystem}: biometric changed = $isBiometricChanged');
          break;
        case _featureSecureEncryptAuthenticate:
          await _markBiometric.authenticateBiometricSecureEncrypt(
            key: 'flutterBiometricKey',
            requestForEncrypt: <String, String>{
              'test': 'P4ssw0rd',
            },
            title: 'Secure Encrypt Authenticate',
            description: 'Secure Encrypt Authenticate',
            negativeText: 'Batal',
            onSuccessAuthenticate: (SuccessAuthenticateEncryptState state) {
              if (state is SuccessAuthenticateEncryptAndroid) {
                _encodedKey = state.encodedIVKey;
                state.encryptedResult.forEach((String key, String? value) {
                  _encryptedResult[key] = '$value';
                });
                _setResult(
                  '${Platform.operatingSystem}: secure encrypt success, encodedIVKey=$_encodedKey, result=$_encryptedResult',
                );
              } else if (state is SuccessAuthenticateEncryptIOS) {
                _encodedKey = state.encodedDomainState;
                _setResult(
                  '${Platform.operatingSystem}: secure encrypt success, encodedDomainState=$_encodedKey',
                );
              }
            },
            onFailedAuthenticate: () {
              _setResult('${Platform.operatingSystem}: secure encrypt failed');
            },
            onErrorAuthenticate: (String code, String? message) {
              _setResult('${Platform.operatingSystem}: secure encrypt error: $code - $message');
            },
            onNegativeButtonClicked: (int which) {
              _setResult('${Platform.operatingSystem}: secure encrypt negative button clicked: $which');
            },
          );
          break;
        case _featureSecureDecryptAuthenticate:
          final String? encodedKey = _encodedKey;
          if (encodedKey == null || encodedKey.isEmpty) {
            _setResult('Run "Secure Encrypt Authenticate" first to generate encoded key.');
            return;
          }
          await _markBiometric.authenticateBiometricSecureDecrypt(
            key: 'flutterBiometricKey',
            encodedIVKey: encodedKey,
            requestForDecrypt: _encryptedResult,
            title: 'Secure Decrypt Authenticate',
            description: 'Secure Decrypt Authenticate',
            negativeText: 'Batal',
            onSuccessAuthenticate: (SuccessAuthenticateDecryptState state) {
              if (state is SuccessAuthenticateDecryptAndroid) {
                _setResult(
                  '${Platform.operatingSystem}: secure decrypt success, result=${state.decryptedResult}',
                );
              } else {
                _setResult('${Platform.operatingSystem}: secure decrypt success');
              }
            },
            onFailedAuthenticate: () {
              _setResult('${Platform.operatingSystem}: secure decrypt failed');
            },
            onErrorAuthenticate: (String code, String? message) {
              _setResult('${Platform.operatingSystem}: secure decrypt error: $code - $message');
            },
            onNegativeButtonClicked: (int which) {
              _setResult('${Platform.operatingSystem}: secure decrypt negative button clicked: $which');
            },
            onCanceled: () {
              _setResult('${Platform.operatingSystem}: secure decrypt canceled');
            },
          );
          break;
      }
    } catch (e) {
      _setResult('Unexpected error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Feature Playground'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              _ResultPanel(
                latestResult: _latestResult,
                resultHistory: _resultHistory,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: _features.length,
                  separatorBuilder: (_, int index) => const SizedBox(height: 10),
                  itemBuilder: (_, int index) {
                    final FeatureModel feature = _features[index];
                    return ItemFeatureWidget(
                      feature: feature,
                      onTap: () => _runFeature(feature),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultPanel extends StatelessWidget {
  final String latestResult;
  final List<String> resultHistory;

  const _ResultPanel({
    required this.latestResult,
    required this.resultHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.55),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Icon(Icons.monitor_heart_rounded),
                SizedBox(width: 8),
                Text(
                  'Result',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(latestResult),
            if (resultHistory.isNotEmpty) ...<Widget>[
              const SizedBox(height: 10),
              const Divider(height: 1),
              const SizedBox(height: 10),
              const Text(
                'Recent Activity',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 90,
                child: ListView.builder(
                  itemCount: resultHistory.length,
                  itemBuilder: (_, int index) {
                    return Text(
                      '• ${resultHistory[index]}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
