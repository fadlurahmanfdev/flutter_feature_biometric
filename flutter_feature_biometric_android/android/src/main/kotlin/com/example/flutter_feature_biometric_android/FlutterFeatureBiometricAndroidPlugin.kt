package com.example.flutter_feature_biometric_android

import android.app.Activity
import android.os.CancellationSignal
import androidx.biometric.BiometricManager.Authenticators
import com.example.flutter_feature_biometric_android.NativeBiometricAuthenticator.*
import com.fadlurahmanfdev.kotlin_feature_identity.data.callback.FeatureBiometricCallBack
import com.fadlurahmanfdev.kotlin_feature_identity.data.enums.BiometricType
import com.fadlurahmanfdev.kotlin_feature_identity.data.enums.FeatureBiometricStatus
import com.fadlurahmanfdev.kotlin_feature_identity.data.enums.FeatureBiometricStatus.*
import com.fadlurahmanfdev.kotlin_feature_identity.plugin.KotlinFeatureBiometric
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel
import java.util.Calendar

/** FlutterFeatureBiometricAndroidPlugin */
class FlutterFeatureBiometricAndroidPlugin : FlutterPlugin, ActivityAware,
    FlutterFeatureBiometricApi {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var kotlinFeatureBiometric: KotlinFeatureBiometric? = null

    private var activity: Activity? = null


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
//        channel =
//            MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_feature_biometric_android")
//        channel.setMethodCallHandler(this)
        FlutterFeatureBiometricApi.setUp(flutterPluginBinding.binaryMessenger, this)
    }


//    override fun onMethodCall(call: MethodCall, result: Result) {
//        if (call.method == "getPlatformVersion") {
//            result.success("Android ${android.os.Build.VERSION.RELEASE}")
//        } else {
//            result.notImplemented()
//        }
//    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        FlutterFeatureBiometricApi.setUp(binding.binaryMessenger, this)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        kotlinFeatureBiometric = KotlinFeatureBiometric(binding.activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        kotlinFeatureBiometric = KotlinFeatureBiometric(binding.activity)
    }

    override fun onDetachedFromActivity() {
        kotlinFeatureBiometric = null
    }

    override fun deviceCanSupportBiometrics(): Boolean {
        return kotlinFeatureBiometric?.haveFeatureBiometric() ?: false
    }

    override fun checkBiometricStatus(authenticator: NativeBiometricAuthenticator): NativeBiometricStatus {
        val flutterAuthenticator = when (authenticator) {
            WEAK -> Authenticators.BIOMETRIC_WEAK
            STRONG -> Authenticators.BIOMETRIC_STRONG
            DEVICE_CREDENTIAL -> Authenticators.DEVICE_CREDENTIAL
        }
        val nativeBiometricStatus =
            kotlinFeatureBiometric?.checkBiometricStatus(flutterAuthenticator) ?: UNKNOWN
        return when (nativeBiometricStatus) {
            SUCCESS -> NativeBiometricStatus.SUCCESS
            NO_BIOMETRIC_AVAILABLE -> NativeBiometricStatus.NO_AVAILABLE
            BIOMETRIC_UNAVAILABLE -> NativeBiometricStatus.UNAVAILABLE
            NONE_ENROLLED -> NativeBiometricStatus.NONE_ENROLLED
            UNKNOWN -> NativeBiometricStatus.UNKNOWN
        }
    }

    override fun authenticate(
        authenticator: NativeBiometricAuthenticator,
        title: String,
        description: String,
        negativeText: String
    ) {
        val nativeType = when (authenticator) {
            WEAK -> BiometricType.WEAK
            STRONG -> BiometricType.STRONG
            DEVICE_CREDENTIAL -> BiometricType.DEVICE_CREDENTIAL
        }
        val cancellationSignal = CancellationSignal()
        kotlinFeatureBiometric?.authenticate(
            type = nativeType,
            title = title,
            description = description,
            negativeText = negativeText,
            cancellationSignal = cancellationSignal,
            callBack = object : FeatureBiometricCallBack {
                override fun onSuccessAuthenticate() {
                    println("MASUK SINI onSuccessAuthenticate")
                }
            }
        )
    }
}
