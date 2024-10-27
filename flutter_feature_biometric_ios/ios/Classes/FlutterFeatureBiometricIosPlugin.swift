import Flutter
import SwiftFeatureBiometric
import LocalAuthentication
import UIKit

public class FlutterFeatureBiometricIosPlugin: NSObject, FlutterPlugin,
    FlutterFeatureBiometricApi
{
    let repository: SwiftFeatureBiometricRepository =
        SwiftFeatureBiometricRepositoryImpl()
    public static func register(with registrar: FlutterPluginRegistrar) {
        let plugin = FlutterFeatureBiometricIosPlugin()
        FlutterFeatureBiometricApiSetup.setUp(
            binaryMessenger: registrar.messenger(), api: plugin)
        registrar.publish(plugin)
    }

    func isDeviceSupportBiometric() throws -> Bool {
        if #available(iOS 11.0, *) {
            return true
        }
        return false
    }

    func canAuthenticate(authenticatorType: NativeBiometricAuthenticatorType)
        throws -> Bool
    {
        switch authenticatorType {
        case .biometric:
            return repository.canAuthenticate(
                policy: .deviceOwnerAuthenticationWithBiometrics)
        case .deviceCredential:
            return repository.canAuthenticate(
                policy: .deviceOwnerAuthentication)
        }
    }
    
    func authenticate(authenticatorType: NativeBiometricAuthenticatorType, description: String, completion: @escaping (Result<NativeAuthResult, any Error>) -> Void) {
        var policy:LAPolicy
        switch authenticatorType {
        case .biometric:
            policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
            break
        case .deviceCredential:
            policy = LAPolicy.deviceOwnerAuthentication
            break;
        }
        
        repository.authenticate(key: "biometricID", policy: policy, localizedReason: description){ result in
            completion(.success(NativeAuthResult(status: .success)))
        }
    }
    
    func authenticateSecure(authenticatorType: NativeBiometricAuthenticatorType, key: String, description: String, completion: @escaping (Result<NativeAuthResult, any Error>) -> Void) {
        if(repository.isBiometricChanged(key: key)){
            completion(.success(NativeAuthResult(status: .biometricChanged)))
        }
        
        repository.authenticate(key: key, policy: .deviceOwnerAuthenticationWithBiometrics, localizedReason: description){ result in
            completion(.success(NativeAuthResult(status: .success)))
        }
    }
}
