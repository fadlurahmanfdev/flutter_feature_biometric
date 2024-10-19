import Flutter
import SwiftFeatureBiometric
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
}
