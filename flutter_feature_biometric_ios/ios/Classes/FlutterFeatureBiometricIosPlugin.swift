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
    
    func canAuthenticate(policy: NativeLAPolicy) throws -> Bool {
        switch policy {
        case .biometric:
            return repository.canAuthenticate(
                policy: .deviceOwnerAuthenticationWithBiometrics)
        case .deviceCredential:
            return repository.canAuthenticate(
                policy: .deviceOwnerAuthentication)
        }
    }
    
    func authenticate(policy: NativeLAPolicy, description: String, completion: @escaping (Result<NativeAuthResult, any Error>) -> Void) {
        var iosPolicy:LAPolicy
        switch policy {
        case .biometric:
            iosPolicy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
            break
        case .deviceCredential:
            iosPolicy = LAPolicy.deviceOwnerAuthentication
            break;
        }
        
        repository.authenticate(key: "biometricID", policy: iosPolicy, localizedReason: description){ result in
            completion(.success(NativeAuthResult(status: .success)))
        }
    }
    
    func authenticateSecure(policy: NativeLAPolicy, key: String, description: String, completion: @escaping (Result<NativeAuthResult, any Error>) -> Void) {
        if(repository.isBiometricChanged(key: key)){
            completion(.success(NativeAuthResult(status: .biometricChanged)))
            return
        }
        
        repository.authenticate(key: key, policy: .deviceOwnerAuthenticationWithBiometrics, localizedReason: description){ result in
            completion(.success(NativeAuthResult(status: .success)))
        }
    }
}
