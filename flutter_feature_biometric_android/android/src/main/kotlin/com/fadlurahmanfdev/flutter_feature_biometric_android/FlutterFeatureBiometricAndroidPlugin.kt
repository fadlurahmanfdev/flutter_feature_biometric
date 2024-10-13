package com.fadlurahmanfdev.flutter_feature_biometric_android

import android.app.Activity
import android.os.CancellationSignal
import androidx.biometric.BiometricManager
import com.fadlurahmanfdev.flutter_feature_biometric_android.NativeBiometricType.DEVICE_CREDENTIAL
import com.fadlurahmanfdev.flutter_feature_biometric_android.NativeBiometricType.STRONG
import com.fadlurahmanfdev.flutter_feature_biometric_android.NativeBiometricType.WEAK
import com.fadlurahmanfdev.kotlin_feature_identity.data.callback.FeatureBiometricCallBack
import com.fadlurahmanfdev.kotlin_feature_identity.data.enums.BiometricType
import com.fadlurahmanfdev.kotlin_feature_identity.data.enums.FeatureBiometricStatus
import com.fadlurahmanfdev.kotlin_feature_identity.data.exception.FeatureBiometricException
import com.fadlurahmanfdev.kotlin_feature_identity.plugin.KotlinFeatureBiometric
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** FlutterFeatureBiometricAndroidPlugin */
class FlutterFeatureBiometricAndroidPlugin : FlutterPlugin, ActivityAware,
    HostFeatureBiometricApi {
    var activity: Activity? = null
    lateinit var kotlinFeatureBiometric: KotlinFeatureBiometric
    lateinit var nativeFeatureBiometricCallback: NativeFeatureBiometricCallback

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        HostFeatureBiometricApi.setUp(flutterPluginBinding.binaryMessenger, this)
        kotlinFeatureBiometric = KotlinFeatureBiometric(activity!!)
        nativeFeatureBiometricCallback = NativeFeatureBiometricCallback(flutterPluginBinding.binaryMessenger)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        HostFeatureBiometricApi.setUp(binding.binaryMessenger, null)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {
        activity = p0.activity
    }

    override fun haveFeatureBiometric(): Boolean {
        return kotlinFeatureBiometric.haveFeatureBiometric()
    }

    override fun haveFaceDetection(): Boolean {
        return kotlinFeatureBiometric.haveFaceDetection()
    }

    override fun canAuthenticate(type: NativeBiometricType): Boolean {
        return when (type) {
            WEAK -> {
                kotlinFeatureBiometric.canAuthenticate(androidx.biometric.BiometricManager.Authenticators.BIOMETRIC_WEAK)
            }

            STRONG -> {
                kotlinFeatureBiometric.canAuthenticate(androidx.biometric.BiometricManager.Authenticators.BIOMETRIC_STRONG)
            }

            DEVICE_CREDENTIAL -> {
                kotlinFeatureBiometric.canAuthenticate(androidx.biometric.BiometricManager.Authenticators.DEVICE_CREDENTIAL)
            }
        }

    }

    override fun checkBiometricStatus(type: NativeBiometricType): NativeAndroidBiometricStatus {
        var status: FeatureBiometricStatus = FeatureBiometricStatus.NO_BIOMETRIC_AVAILABLE

        status = when (type) {
            WEAK -> {
                kotlinFeatureBiometric.checkBiometricStatus(BiometricManager.Authenticators.BIOMETRIC_WEAK)
            }

            STRONG -> {
                kotlinFeatureBiometric.checkBiometricStatus(BiometricManager.Authenticators.BIOMETRIC_STRONG)
            }

            DEVICE_CREDENTIAL -> {
                kotlinFeatureBiometric.checkBiometricStatus(BiometricManager.Authenticators.DEVICE_CREDENTIAL)
            }
        }
        return when (status) {
            FeatureBiometricStatus.SUCCESS -> NativeAndroidBiometricStatus.SUCCESS
            FeatureBiometricStatus.NO_BIOMETRIC_AVAILABLE -> NativeAndroidBiometricStatus.NO_BIOMETRIC_AVAILABLE
            FeatureBiometricStatus.BIOMETRIC_UNAVAILABLE -> NativeAndroidBiometricStatus.UNAVAILABLE
            FeatureBiometricStatus.NONE_ENROLLED -> NativeAndroidBiometricStatus.NONE_ENROLLED
            FeatureBiometricStatus.UNKNOWN -> NativeAndroidBiometricStatus.UNKNOWN
        }
    }


    override fun authenticate(
        type: NativeBiometricType,
        title: String,
        description: String,
        negativeText: String,
    ) {
        val biometricType = when (type) {
            WEAK -> BiometricType.WEAK
            STRONG -> throw FeatureBiometricException(code = "00", message = "NOT_AVAILABLE")
            DEVICE_CREDENTIAL -> BiometricType.DEVICE_CREDENTIAL
        }
        Result.success("sa")
//        callback.onSuccessAuthenticate {  }
        kotlinFeatureBiometric.authenticate(
            type = biometricType,
            title = title,
            description = description,
            negativeText = negativeText,
            callBack = object : FeatureBiometricCallBack {
                override fun onSuccessAuthenticate() {
                }
            },
            cancellationSignal = CancellationSignal(),
        )
    }
}
