package com.fadlurahmanfdev.flutter_feature_biometric_android

import android.app.Activity
import android.content.DialogInterface
import android.os.CancellationSignal
import androidx.biometric.BiometricManager.Authenticators
import com.fadlurahmanfdev.flutter_feature_biometric_android.NativeBiometricAuthenticator.*
import com.fadlurahmanfdev.kotlin_feature_identity.data.callback.FeatureBiometricCallBack
import com.fadlurahmanfdev.kotlin_feature_identity.data.callback.FeatureBiometricDecryptSecureCallBack
import com.fadlurahmanfdev.kotlin_feature_identity.data.callback.FeatureBiometricEncryptSecureCallBack
import com.fadlurahmanfdev.kotlin_feature_identity.data.enums.BiometricType
import com.fadlurahmanfdev.kotlin_feature_identity.data.enums.FeatureBiometricStatus.*
import com.fadlurahmanfdev.kotlin_feature_identity.data.exception.FeatureBiometricException
import com.fadlurahmanfdev.kotlin_feature_identity.plugin.KotlinFeatureBiometric
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel
import javax.crypto.Cipher
import android.util.Base64

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
        FlutterFeatureBiometricApi.setUp(flutterPluginBinding.binaryMessenger, this)
    }

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

    override fun isDeviceSupportBiometric(): Boolean {
        return kotlinFeatureBiometric?.haveFeatureBiometric() ?: false
    }

    override fun checkAuthenticationStatus(authenticator: NativeBiometricAuthenticator): NativeBiometricStatus {
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

    override fun canAuthenticate(
        authenticator: NativeBiometricAuthenticator,
    ): Boolean {
        return checkAuthenticationStatus(authenticator) == NativeBiometricStatus.SUCCESS
    }

    override fun authenticate(
        authenticator: NativeBiometricAuthenticator,
        title: String,
        description: String,
        negativeText: String,
        callback: (Result<NativeAuthResult>) -> Unit
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
                    callback.invoke(
                        Result.success(
                            NativeAuthResult(
                                status = NativeAuthResultStatus.SUCCESS
                            )
                        )
                    )
                }

                override fun onFailedAuthenticate() {
                    super.onFailedAuthenticate()
                    callback.invoke(
                        Result.success(
                            NativeAuthResult(
                                status = NativeAuthResultStatus.FAILED
                            )
                        )
                    )
                }

                override fun onErrorAuthenticate(exception: FeatureBiometricException) {
                    super.onErrorAuthenticate(exception)
                    callback.invoke(
                        Result.success(
                            NativeAuthResult(
                                status = NativeAuthResultStatus.ERROR,
                                failure = NativeAuthFailure(
                                    code = exception.code,
                                    message = exception.message,
                                )
                            )
                        )
                    )
                }

                override fun onDialogClick(dialogInterface: DialogInterface?, which: Int) {
                    super.onDialogClick(dialogInterface, which)
                    callback.invoke(
                        Result.success(
                            NativeAuthResult(
                                status = NativeAuthResultStatus.DIALOG_CLICKED,
                                dialogClickResult = NativeAuthDialogClickResult(which = which.toLong())
                            )
                        )
                    )
                }

                override fun onCanceled() {
                    super.onCanceled()
                    callback.invoke(
                        Result.success(
                            NativeAuthResult(
                                status = NativeAuthResultStatus.CANCELED
                            )
                        )
                    )
                }
            }
        )
    }

    override fun secureEncryptAuthenticate(
        alias: String,
        requestForEncrypt: Map<String, String>,
        title: String,
        description: String,
        negativeText: String,
        callback: (Result<NativeSecureEncryptAuthResult>) -> Unit
    ) {
        val cancellationSignal = CancellationSignal()
        kotlinFeatureBiometric?.authenticateSecureEncrypt(
            title = title,
            description = description,
            negativeText = negativeText,
            cancellationSignal = cancellationSignal,
            alias = alias,
            callBack = object : FeatureBiometricEncryptSecureCallBack {
                override fun onSuccessAuthenticateEncryptSecureBiometric(
                    cipher: Cipher,
                    encodedIvKey: String
                ) {
                    val encryptedResponse: HashMap<String, String?> = hashMapOf()
                    requestForEncrypt.forEach { it ->
                        encryptedResponse[it.key] =
                            kotlinFeatureBiometric?.encrypt(cipher, it.value)
                    }
                    callback.invoke(
                        Result.success(
                            NativeSecureEncryptAuthResult(
                                status = NativeAuthResultStatus.SUCCESS,
                                encodedIVKey = encodedIvKey,
                                encryptedResult = encryptedResponse
                            )
                        )
                    )
                }

                override fun onErrorAuthenticate(exception: FeatureBiometricException) {
                    super.onErrorAuthenticate(exception)
                    callback.invoke(
                        Result.success(
                            NativeSecureEncryptAuthResult(
                                status = NativeAuthResultStatus.ERROR,
                                failure = NativeAuthFailure(
                                    code = exception.code,
                                    message = exception.message,
                                )
                            )
                        )
                    )
                }

                override fun onFailedAuthenticate() {
                    super.onFailedAuthenticate()
                    callback.invoke(
                        Result.success(
                            NativeSecureEncryptAuthResult(
                                status = NativeAuthResultStatus.FAILED,
                            )
                        )
                    )
                }

                override fun onDialogClick(dialogInterface: DialogInterface?, which: Int) {
                    super.onDialogClick(dialogInterface, which)
                    callback.invoke(
                        Result.success(
                            NativeSecureEncryptAuthResult(
                                status = NativeAuthResultStatus.DIALOG_CLICKED,
                                dialogClickResult = NativeAuthDialogClickResult(
                                    which = which.toLong()
                                )
                            )
                        )
                    )
                }

                override fun onCanceled() {
                    super.onCanceled()
                    callback.invoke(
                        Result.success(
                            NativeSecureEncryptAuthResult(
                                status = NativeAuthResultStatus.CANCELED
                            )
                        )
                    )
                }
            }
        )
    }

    override fun secureDecryptAuthenticate(
        alias: String,
        encodedIVKey: String,
        requestForDecrypt: Map<String, String>,
        title: String,
        description: String,
        negativeText: String,
        callback: (Result<NativeSecureDecryptAuthResult>) -> Unit
    ) {
        val cancellationSignal = CancellationSignal()
        kotlinFeatureBiometric?.authenticateSecureDecrypt(
            title = title,
            encodedIvKey = encodedIVKey,
            description = description,
            negativeText = negativeText,
            cancellationSignal = cancellationSignal,
            alias = alias,
            callBack = object : FeatureBiometricDecryptSecureCallBack {

                override fun onSuccessAuthenticateDecryptSecureBiometric(cipher: Cipher) {
                    val decryptedResponse: HashMap<String, String?> = hashMapOf()
                    requestForDecrypt.forEach { it ->
                        val decoded = Base64.decode(it.value, Base64.NO_WRAP)
                        val decrypted = kotlinFeatureBiometric?.decrypt(cipher, decoded)
                        decryptedResponse[it.key] = decrypted

                    }
                    callback.invoke(
                        Result.success(
                            NativeSecureDecryptAuthResult(
                                status = NativeAuthResultStatus.SUCCESS,
                                decryptedResult = decryptedResponse,
                            )
                        )
                    )
                }

                override fun onErrorAuthenticate(exception: FeatureBiometricException) {
                    super.onErrorAuthenticate(exception)
                    callback.invoke(
                        Result.success(
                            NativeSecureDecryptAuthResult(
                                status = NativeAuthResultStatus.ERROR,
                                failure = NativeAuthFailure(
                                    code = exception.code,
                                    message = exception.message,
                                )
                            )
                        )
                    )
                }

                override fun onFailedAuthenticate() {
                    super.onFailedAuthenticate()
                    callback.invoke(
                        Result.success(
                            NativeSecureDecryptAuthResult(
                                status = NativeAuthResultStatus.FAILED,
                            )
                        )
                    )
                }

                override fun onDialogClick(dialogInterface: DialogInterface?, which: Int) {
                    super.onDialogClick(dialogInterface, which)
                    callback.invoke(
                        Result.success(
                            NativeSecureDecryptAuthResult(
                                status = NativeAuthResultStatus.DIALOG_CLICKED,
                                dialogClickResult = NativeAuthDialogClickResult(
                                    which = which.toLong()
                                )
                            )
                        )
                    )
                }

                override fun onCanceled() {
                    super.onCanceled()
                    println("MASUK SINI CANCEL")
                    callback.invoke(
                        Result.success(
                            NativeSecureDecryptAuthResult(
                                status = NativeAuthResultStatus.CANCELED
                            )
                        )
                    )
                }
            }
        )
    }
}
