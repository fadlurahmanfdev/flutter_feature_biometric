# mark_biometric

Flutter plugin for biometric and device credential authentication on Android and iOS.

## Public API

All public APIs are exposed from:

- `package:mark_biometric/mark_biometric.dart`

### `MarkBiometric`

Create once, then call the APIs below:

```dart
final biometric = MarkBiometric();
```

#### 1) `isDeviceSupportBiometric()`

Checks whether the device has biometric capability.

```dart
final supported = await biometric.isDeviceSupportBiometric();
```

#### 2) `checkAuthenticatorStatus(MarkAuthenticatorType authenticator)`

Checks whether the selected authenticator can be used right now.

```dart
final status = await biometric.checkAuthenticatorStatus(
  MarkAuthenticatorType.biometric,
);
```

#### 3) `canSecureAuthenticate()`

Checks whether secure encrypt/decrypt authentication flow is available.

```dart
final canSecure = await biometric.canSecureAuthenticate();
```

#### 4) `authenticate(...)`

Runs standard authentication (biometric or device credential).

```dart
await biometric.authenticate(
  authenticatorType: MarkAuthenticatorType.biometric,
  title: 'Authenticate',
  description: 'Please verify your identity',
  negativeText: 'Cancel',
  onSuccessAuthenticate: () {},
  onErrorAuthenticate: (code, message) {},
);
```

#### 5) `isBiometricChanged({required String key, required String encodedKey})`

Checks whether biometric enrollment changed after secure registration.

```dart
final changed = await biometric.isBiometricChanged(
  key: 'flutterBiometricKey',
  encodedKey: encodedKey,
);
```

#### 6) `authenticateBiometricSecureEncrypt(...)`

Runs secure authentication and encrypts the request payload.

```dart
await biometric.authenticateBiometricSecureEncrypt(
  key: 'flutterBiometricKey',
  requestForEncrypt: {'token': 'my-secret'},
  title: 'Register Biometric',
  description: 'Confirm biometric to encrypt data',
  negativeText: 'Cancel',
  onSuccessAuthenticate: (state) {},
  onErrorAuthenticate: (code, message) {},
);
```

#### 7) `authenticateBiometricSecureDecrypt(...)`

Runs secure authentication and decrypts encrypted payload.

```dart
await biometric.authenticateBiometricSecureDecrypt(
  key: 'flutterBiometricKey',
  encodedIVKey: encodedKey,
  requestForDecrypt: encryptedResult,
  title: 'Login with Biometric',
  description: 'Confirm biometric to decrypt data',
  negativeText: 'Cancel',
  onSuccessAuthenticate: (state) {},
  onErrorAuthenticate: (code, message) {},
);
```

## Public Enums, Models, and Exception

Also exported by `mark_biometric`:

- `MarkAuthenticatorType`
  - `biometric`
  - `deviceCredential`
- `MarkAuthenticatorStatus`
  - `success`
  - `noHardwareAvailable`
  - `unavailable`
  - `noneEnrolled`
  - `securityUpdateRequired`
  - `unsupportedOSVersion`
  - `unknown`
- `SuccessAuthenticateEncryptState`
  - `SuccessAuthenticateEncryptAndroid`
  - `SuccessAuthenticateEncryptIOS`
- `SuccessAuthenticateDecryptState`
  - `SuccessAuthenticateDecryptAndroid`
  - `SuccessAuthenticateDecryptIOS`
- `FeatureBiometricException`

## Possible Exceptions and Error Codes

This plugin reports errors in two common ways:

1. Through `onErrorAuthenticate(code, message)` callbacks.
2. As `PlatformException` from channel calls (`Future` APIs).

### Callback error codes

Known callback codes that can come from this library:

- `IOS_UNKNOWN_POLICY`
- `IOS_UNKNOWN_RESULT`
- `IOS_UNKNOWN_UNABLE_AUTHENTICATE`
- `BIOMETRIC_CHANGED` (iOS secure flows)
- `GENERAL` (iOS secure flows fallback)
- `FEATURE_AUTHENTICATION_MISSING` (Android when native feature auth is unavailable)

Android can also forward native `FeatureIdentityException.code` values from the underlying authentication module. Those values are platform-defined and may vary by native implementation/version.

### `PlatformException` codes

Channel-level exceptions can contain:

- `channel-error` (channel connection issue)
- `null-error` (native side returned null for non-null response)
- Native custom platform codes returned by Android/iOS Pigeon handlers

## Notes

- Some prompt fields are platform-specific and can be ignored on iOS (`title`, `subTitle`, `negativeText`, `confirmationRequired`).
- Secure encrypt/decrypt output is platform-specific. Always branch by returned state type (`Android` or `iOS`).
