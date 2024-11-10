# Description

Flutter plugin to simplified device authentication or biometric authentication only for android &
ios.

## Key Features

### Check Whether Device Support Biometric

Check whether device support biometric authentication or not.

```dart
Future<void> screenFunction() async {
  final isSupportedBiometric = await FlutterFeatureBiometric().isDeviceSupportBiometric();
}
```

### Check Authenticator Status

Check whether specific authenticator can authenticate.

The authenticator available:

| Authenticator          | Desc                                             |
|------------------------|--------------------------------------------------|
| biometric              | biometric authentication.                        |
| deviceCredential       | device authentication (e.g., PIN, Password, etc) |

Return `AuthenticatorStatus`

| Status                 | Desc                                                      |
|------------------------|-----------------------------------------------------------|
| success                | enable authenticate.                                      |
| noHardwareAvailable    | no authenticator hardware available for authentication.   |
| unavailable            | authenticator currently unavailable.                      |
| noneEnrolled           | device not yet enrolled with specific authenticator.      |
| securityUpdateRequired | device need to update first before use the authenticator. |
| unsupportedOSVersion   | the device is not supported with authenticator.           |
| unknown                | other status that is unmapping.                           |

```dart
Future<void> screenFunction() async {
  final status =
    await FlutterFeatureBiometric().checkAuthenticatorStatus(BiometricAuthenticatorType.biometric);
}
```

## Check Secure Authentication

Whether device can authenticate with secure authentication.

Secure authentication means that every biometric

```dart
Future<void> screenFunction() async {
  final canSecureAuthenticate =
    await FlutterFeatureBiometric().canSecureAuthenticate();
}
```

## Device Credential Authentication

Authenticate using device credential

| Parameter                 | Type                                  | android | iOS | Desc                                                                                          |
|---------------------------|---------------------------------------|---------|-----|-----------------------------------------------------------------------------------------------|
| tile                      | String                                | v       | x   | The title will be shown in prompt authentication.                                             |
| subTitle                  | String                                | v       | x   | The subtitle will be shown in prompt authentication.                                          |
| description               | String                                | v       | v   | The description will be shown in prompt authentication.                                       |
| negativeText              | String                                | v       | x   | The button text will be shown in prompt authentication.                                       |
| confirmationRequired      | bool                                  | v       | x   | If true, confirmation after biometric will be shown before onSuccessAuthenticate() triggered. |
| onSuccessAuthenticate     | Function()                            | v       | v   | This will be triggered if successfully authenticated.                                         |
| onFailedAuthenticate      | Function()                            | v       | v   | This will be triggered if failed authenticated.                                               |
| onErrorAuthenticate       | Function(String code, String message) | v       | x   | This will be triggered if authenticate catch an error.                                        |
| onNegativeButtonClicked   | Function(int)                         | v       | x   | This will be triggered if negative text clicked.                                              |
| onCanceled                | Function()                            | v       | x   | This will be triggered if user cancel through device bottom nav bar.                          |

```dart
Future<void> screenFunction() async {
  FlutterFeatureBiometric().authenticateDeviceCredential(
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
}
```

## Biometric Authentication

Authenticate using biometric

| Parameter                 | Type                                  | android | iOS | Desc                                                                                          |
|---------------------------|---------------------------------------|---------|-----|-----------------------------------------------------------------------------------------------|
| tile                      | String                                | v       | x   | The title will be shown in prompt authentication.                                             |
| subTitle                  | String                                | v       | x   | The subtitle will be shown in prompt authentication.                                          |
| description               | String                                | v       | v   | The description will be shown in prompt authentication.                                       |
| negativeText              | String                                | v       | x   | The button text will be shown in prompt authentication.                                       |
| confirmationRequired      | bool                                  | v       | x   | If true, confirmation after biometric will be shown before onSuccessAuthenticate() triggered. |
| onSuccessAuthenticate     | Function()                            | v       | v   | This will be triggered if successfully authenticated.                                         |
| onFailedAuthenticate      | Function()                            | v       | v   | This will be triggered if failed authenticated.                                               |
| onErrorAuthenticate       | Function(String code, String message) | v       | x   | This will be triggered if authenticate catch an error.                                        |
| onNegativeButtonClicked   | Function(int)                         | v       | x   | This will be triggered if negative text clicked.                                              |
| onCanceled                | Function()                            | v       | x   | This will be triggered if user cancel through device bottom nav bar.                          |

```dart
Future<void> screenFunction() async {
  FlutterFeatureBiometric().authenticateBiometric(
    title: "Title - Biometric Authenticate",
    description: "Description - Biometric Authenticate",
    confirmationRequired: true,
    negativeText: "Cancel",
    onSuccessAuthenticate: () {
      print("${Platform.operatingSystem} - Success authenticate biometric");
    },
    onErrorAuthenticate: (code, message) {
      print("${Platform.operatingSystem} - Error authenticate biometric: $code - $message");
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
}
```

## Secure Encrypt Authentication

Secure encrypt authentication, usually used in register biometric.

| Parameter                | Type                                            | android | iOS | Desc                                                                                          |
|--------------------------|-------------------------------------------------|---------|-----|-----------------------------------------------------------------------------------------------|
| key                      | String                                          | v       | v   | The alias key you will store the secret. (IT'S NOT CREDENTIAL)                                |
| requestForEncrypt        | Map<String, String>                             | v       | x   | The map of data want to encrypt                                                               |
| tile                     | String                                          | v       | x   | The title will be shown in prompt authentication.                                             |
| subTitle                 | String                                          | v       | x   | The subtitle will be shown in prompt authentication.                                          |
| description              | String                                          | v       | v   | The description will be shown in prompt authentication.                                       |
| negativeText             | String                                          | v       | x   | The button text will be shown in prompt authentication.                                       |
| confirmationRequired     | bool                                            | v       | x   | If true, confirmation after biometric will be shown before onSuccessAuthenticate() triggered. |
| onSuccessAuthenticate    | Function(SuccessAuthenticateEncryptState state) | v       | v   | This will be triggered if successfully authenticated.                                         |
| onFailedAuthenticate     | Function()                                      | v       | v   | This will be triggered if failed authenticated.                                               |
| onErrorAuthenticate      | Function(String code, String message)           | v       | x   | This will be triggered if authenticate catch an error.                                        |
| onNegativeButtonClicked  | Function(int)                                   | v       | x   | This will be triggered if negative text clicked.                                              |
| onCanceled               | Function()                                      | v       | x   | This will be triggered if user cancel through device bottom nav bar.                          |

```dart
Future<void> screenFunction() async {
  FlutterFeatureBiometric().authenticateBiometricSecureEncrypt(
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
        print("Encoded IV Key: $encodedIVKey");
        print("Result: $encryptedResult");
      }
      print("${Platform.operatingSystem} - Success Encrypt Authenticate");
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
}
```

## Secure Decrypt Authentication

Secure decrypt authentication, usually used in login or want to expose saved data using biometric.

| Parameter                 | Type                                            | android | iOS | Desc                                                                                          |
|---------------------------|-------------------------------------------------|---------|-----|-----------------------------------------------------------------------------------------------|
| key                       | String                                          | v       | v   | The alias key you will store the secret. (IT'S NOT CREDENTIAL)                                |
| encodedIVKey              | String                                          | v       | x   | The encoded IV Key return from encrypt authentication.                                        |
| requestForDecrypt         | Map<String, String>                             | v       | x   | The map want to decrypt.                                                                      |
| tile                      | String                                          | v       | x   | The title will be shown in prompt authentication.                                             |
| subTitle                  | String                                          | v       | x   | The subtitle will be shown in prompt authentication.                                          |
| description               | String                                          | v       | v   | The description will be shown in prompt authentication.                                       |
| negativeText              | String                                          | v       | x   | The button text will be shown in prompt authentication.                                       |
| confirmationRequired      | bool                                            | v       | x   | If true, confirmation after biometric will be shown before onSuccessAuthenticate() triggered. |
| onSuccessAuthenticate     | Function(SuccessAuthenticateEncryptState state) | v       | v   | This will be triggered if successfully authenticated.                                         |
| onFailedAuthenticate      | Function()                                      | v       | v   | This will be triggered if failed authenticated.                                               |
| onErrorAuthenticate       | Function(String code, String message)           | v       | x   | This will be triggered if authenticate catch an error.                                        |
| onNegativeButtonClicked   | Function(int)                                   | v       | x   | This will be triggered if negative text clicked.                                              |
| onCanceled                | Function()                                      | v       | x   | This will be triggered if user cancel through device bottom nav bar.                          |

```dart
Future<void> screenFunction() async {
  FlutterFeatureBiometric().authenticateBiometricSecureDecrypt(
    key: "flutterBiometricKey",
    encodedIVKey: "MbUhu6SsOk9vN8iJ/Td1lQ==",
    requestForDecrypt: {
      "test": "xZqWsEIQLL/IaurzD5bZAQ==",
    },
    title: "Secure Decrypt Authenticate",
    description: "Secure Decrypt Authenticate",
    negativeText: "Cancel",
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
}
```
