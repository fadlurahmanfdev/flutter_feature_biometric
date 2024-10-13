package com.fadlurahmanfdev.flutter_feature_biometric_android

import android.app.Activity
import android.content.DialogInterface
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
import java.util.Calendar

/** FlutterFeatureBiometricAndroidPlugin */
class FlutterFeatureBiometricAndroidPlugin : FlutterPlugin, ActivityAware,
    HostFeatureBiometricApi {
    var activity: Activity? = null
    lateinit var kotlinFeatureBiometric: KotlinFeatureBiometric

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        println("MASUK onAttachedToEngine: ${Calendar.getInstance().time}")
        HostFeatureBiometricApi.setUp(flutterPluginBinding.binaryMessenger, this)
        kotlinFeatureBiometric = KotlinFeatureBiometric(activity!!)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        println("MASUK onDetachedFromEngine: ${Calendar.getInstance().time}")
        HostFeatureBiometricApi.setUp(binding.binaryMessenger, null)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        println("MASUK onDetachedFromActivityForConfigChanges: ${Calendar.getInstance().time}")
        activity = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        println("MASUK onAttachedToActivity: ${Calendar.getInstance().time}")
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        println("MASUK onDetachedFromActivity: ${Calendar.getInstance().time}")
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {
        println("MASUK onReattachedToActivityForConfigChanges: ${Calendar.getInstance().time}")
        activity = p0.activity
    }

    override fun haveFeatureBiometric(): Boolean {
        println("MASUK haveFeatureBiometric: ${Calendar.getInstance().time}")
//        return kotlinFeatureBiometric.haveFeatureBiometric()
        return false
    }

    override fun haveFaceDetection(): Boolean {
//        return kotlinFeatureBiometric.haveFaceDetection()
        return false
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
        callback: (Result<String>) -> Unit
    ) {
        val biometricType = when (type) {
            WEAK -> BiometricType.WEAK
            STRONG -> throw FeatureBiometricException(code = "00", message = "NOT_AVAILABLE")
            DEVICE_CREDENTIAL -> BiometricType.DEVICE_CREDENTIAL
        }
        kotlinFeatureBiometric.authenticate(
            type = biometricType,
            title = title,
            description = description,
            negativeText = negativeText,
            callBack = object : FeatureBiometricCallBack {
                override fun onSuccessAuthenticate() {
                    callback.invoke(Result.success("onSuccessAuthenticate"))
                }

                override fun onFailedAuthenticate() {
                    super.onFailedAuthenticate()
                    callback.invoke(Result.success("onFailedAuthenticate"))
                }

                override fun onErrorAuthenticate(exception: FeatureBiometricException) {
                    super.onErrorAuthenticate(exception)
                    callback.invoke(Result.success("onErrorAuthenticate ${exception.code} & ${exception.message}"))
                }

                override fun onDialogClick(dialogInterface: DialogInterface?, which: Int) {
                    super.onDialogClick(dialogInterface, which)
                    callback.invoke(Result.success("onDialogClick $which"))
                }
            },
            cancellationSignal = CancellationSignal(),
        )
    }
}
