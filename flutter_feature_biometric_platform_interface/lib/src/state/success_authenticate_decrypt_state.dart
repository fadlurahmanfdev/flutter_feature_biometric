abstract class SuccessAuthenticateDecryptState {}

class SuccessAuthenticateDecryptAndroid extends SuccessAuthenticateDecryptState {
  Map<String, String?> decryptedResult;

  SuccessAuthenticateDecryptAndroid({
    required this.decryptedResult,
  });
}

class SuccessAuthenticateDecryptIOS extends SuccessAuthenticateDecryptState {}