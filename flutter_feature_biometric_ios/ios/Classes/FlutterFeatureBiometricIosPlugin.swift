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
    
    func canAuthenticate(laPolicy: IOSLAPolicy) throws -> Bool {
        switch laPolicy {
        case .biometric:
            return repository.canAuthenticate(
                policy: .deviceOwnerAuthenticationWithBiometrics)
        case .deviceCredential:
            return repository.canAuthenticate(
                policy: .deviceOwnerAuthentication)
        }
    }
    
    func authenticate(laPolicy: IOSLAPolicy, description: String, completion: @escaping (Result<IOSAuthenticationResult, any Error>) -> Void) {
        var iosPolicy:LAPolicy
        switch laPolicy {
        case .biometric:
            iosPolicy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
            break
        case .deviceCredential:
            iosPolicy = LAPolicy.deviceOwnerAuthentication
            break;
        }
        
        repository.authenticate(policy: iosPolicy, localizedReason: description){ result in
            completion(.success(IOSAuthenticationResult(status: .success)))
        }
    }
    
    func isBiometricChanged(key: String) throws -> Bool {
        return repository.isBiometricChanged(key: key)
    }
    
    func authenticateSecure(laPolicy: IOSLAPolicy, key: String, description: String, completion: @escaping (Result<IOSAuthenticationResult, any Error>) -> Void) {
        if(repository.isBiometricChanged(key: key)){
            completion(.success(IOSAuthenticationResult(status: .biometricChanged)))
            return
        }
        
        repository.secureAuthenticate(key: key, policy: .deviceOwnerAuthenticationWithBiometrics, localizedReason: description){ result in
            completion(.success(IOSAuthenticationResult(status: .success)))
        }
    }
}
