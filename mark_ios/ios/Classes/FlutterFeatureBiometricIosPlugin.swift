import Flutter
import SwiftFeatureBiometric
import LocalAuthentication
import UIKit

public class MarkIOSPlugin: NSObject, FlutterPlugin,
    MarkApi
{
    let repository: SwiftFeatureBiometricRepository =
        SwiftFeatureBiometricRepositoryImpl()
    public static func register(with registrar: FlutterPluginRegistrar) {
        let plugin = MarkIOSPlugin()
        MarkApiSetup.setUp(
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
    
    func isBiometricChanged(alias: String, encodedDomainState: String) throws -> Bool {
        let defaults = UserDefaults.standard
        let oldDomainState = defaults.object(forKey: alias) as? Data
        return encodedDomainState != oldDomainState?.base64EncodedString()
    }
    
    func authenticateSecureEncrypt(laPolicy: IOSLAPolicy, alias: String, description: String, completion: @escaping (Result<IOSAuthenticationResult, any Error>) -> Void) {
        repository.secureAuthenticate(key: alias, policy: .deviceOwnerAuthenticationWithBiometrics, localizedReason: description){ result in
            switch result   {
            case .success(let encodedDomainState):
                completion(.success(IOSAuthenticationResult(status: .success, encodedDomainState: encodedDomainState)))
                break;
            case .canceled:
                completion(.success(IOSAuthenticationResult(status: .canceled)))
                break;
            }
        }
    }
    
    func authenticateSecureDecrypt(laPolicy: IOSLAPolicy, encodedDomainState: String, alias: String, description: String, completion: @escaping (Result<IOSAuthenticationResult, any Error>) -> Void) {
        if(repository.isBiometricChanged(key: alias, encodedDomainState: encodedDomainState)){
            completion(.success(IOSAuthenticationResult(status: .biometricChanged)))
            return
        }
        
        repository.secureAuthenticate(key: alias, policy: .deviceOwnerAuthenticationWithBiometrics, localizedReason: description){ result in
            switch result   {
            case .success(let encodedDomainState):
                completion(.success(IOSAuthenticationResult(status: .success)))
                break;
            case .canceled:
                completion(.success(IOSAuthenticationResult(status: .canceled)))
                break;
            }
        }
    }
}
