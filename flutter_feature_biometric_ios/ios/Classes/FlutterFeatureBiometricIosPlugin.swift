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
        print("key: \(key)")
        let defaults = UserDefaults.standard
        let oldDomainState = defaults.object(forKey: key) as? Data
        print("old domain state: \(oldDomainState?.base64EncodedString())")
        let currentDomainState = LAContext().evaluatedPolicyDomainState
        print("current domain state: \(currentDomainState?.base64EncodedString())")
        return currentDomainState != oldDomainState
//        return repository.isBiometricChanged(key: key)
    }
    
    func authenticateSecure(laPolicy: IOSLAPolicy, key: String, description: String, completion: @escaping (Result<IOSAuthenticationResult, any Error>) -> Void) {
        print("masuk authenticateSecure \(repository.isBiometricChanged(key: key))")
//        if(repository.isBiometricChanged(key: key)){
//            completion(.success(IOSAuthenticationResult(status: .biometricChanged)))
//            return
//        }
        
//        repository.secureAuthenticate(key: key, policy: .deviceOwnerAuthenticationWithBiometrics, localizedReason: description){ result in
//            completion(.success(IOSAuthenticationResult(status: .success)))
//        }
        
        print("key: \(key)")
        print("domain state \((UserDefaults.standard.object(forKey: key) as? Data)?.base64EncodedString())")
        let context = LAContext()
        let defaults = UserDefaults.standard
        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: description
        ) { success, error in
            if success {
                let domainState = context.evaluatedPolicyDomainState
                print("domain state \(domainState?.base64EncodedString())")
                defaults.set(domainState, forKey: key)
                completion(.success(IOSAuthenticationResult(status: .biometricChanged)))
//                completion(
//                    .success(
//                        encodedDomainState: domainState?.base64EncodedString()))
            } else {
                completion(.canceled)
            }

        }
    }
}
