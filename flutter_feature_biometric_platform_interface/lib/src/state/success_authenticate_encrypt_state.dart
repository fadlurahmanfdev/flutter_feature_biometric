abstract class SuccessAuthenticateEncryptState {}

class SuccessAuthenticateEncryptAndroid extends SuccessAuthenticateEncryptState {
  String encodedIVKey;
  Map<String, String?> encryptedResult;

  SuccessAuthenticateEncryptAndroid({
    required this.encodedIVKey,
    required this.encryptedResult,
  });
}

class SuccessAuthenticateEncryptIOS extends SuccessAuthenticateEncryptState {}