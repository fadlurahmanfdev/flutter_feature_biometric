package com.fadlurahmanfdev.mark_android

import android.app.Activity
import android.os.Build
import android.util.Base64
import androidx.annotation.RequiresApi
import androidx.fragment.app.FragmentActivity
import com.fadlurahmanfdev.kotlin_feature_identity.data.callback.AuthenticationCallBack
import com.fadlurahmanfdev.kotlin_feature_identity.data.callback.SecureAuthenticationDecryptCallBack
import com.fadlurahmanfdev.kotlin_feature_identity.data.callback.SecureAuthenticationEncryptCallBack
import com.fadlurahmanfdev.kotlin_feature_identity.data.enums.FeatureAuthenticationStatus
import com.fadlurahmanfdev.kotlin_feature_identity.data.enums.FeatureAuthenticatorType
import com.fadlurahmanfdev.kotlin_feature_identity.data.exception.FeatureIdentityException
import com.fadlurahmanfdev.kotlin_feature_identity.plugin.FeatureAuthentication
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel
import javax.crypto.Cipher

/** MarkAndroidPlugin */
class MarkAndroidPlugin : FlutterPlugin, ActivityAware,
    MarkApi {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var featureAuthentication: FeatureAuthentication? = null


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        MarkApi.setUp(flutterPluginBinding.binaryMessenger, this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        MarkApi.setUp(binding.binaryMessenger, this)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        featureAuthentication = FeatureAuthentication(binding.activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        featureAuthentication = FeatureAuthentication(binding.activity)
    }

    override fun onDetachedFromActivity() {
        featureAuthentication = null
    }

    override fun deleteSecretKey(alias: String) {
        featureAuthentication?.deleteSecretKey(alias)
    }

    override fun isDeviceSupportFingerprint(): Boolean {
        return featureAuthentication?.isDeviceSupportFingerprint() ?: false
    }

    override fun isDeviceSupportFaceAuth(): Boolean {
        return featureAuthentication?.isDeviceSupportFaceAuth() ?: false
    }

    override fun isDeviceSupportBiometric(): Boolean {
        return featureAuthentication?.isDeviceSupportBiometric() ?: false
    }

    @RequiresApi(Build.VERSION_CODES.M)
    override fun isFingerprintEnrolled(): Boolean {
        return featureAuthentication?.isFingerprintEnrolled() ?: false
    }

    @RequiresApi(Build.VERSION_CODES.M)
    override fun isDeviceCredentialEnrolled(): Boolean {
        return featureAuthentication?.isDeviceCredentialEnrolled() ?: false
    }

    override fun checkAuthenticatorStatus(androidAuthenticatorType: AndroidAuthenticatorType): AndroidAuthenticatorStatus {
        val authenticatorType = when (androidAuthenticatorType) {
            AndroidAuthenticatorType.BIOMETRIC -> FeatureAuthenticatorType.BIOMETRIC
            AndroidAuthenticatorType.DEVICE_CREDENTIAL -> FeatureAuthenticatorType.DEVICE_CREDENTIAL
        }

        val authenticatorStatus =
            featureAuthentication?.checkAuthenticatorStatus(authenticatorType)
        return when (authenticatorStatus) {
            FeatureAuthenticationStatus.SUCCESS -> AndroidAuthenticatorStatus.SUCCESS
            FeatureAuthenticationStatus.NO_HARDWARE -> AndroidAuthenticatorStatus.NO_HARDWARE_AVAILABLE
            FeatureAuthenticationStatus.UNAVAILABLE -> AndroidAuthenticatorStatus.UNAVAILABLE
            FeatureAuthenticationStatus.NONE_ENROLLED -> AndroidAuthenticatorStatus.NONE_ENROLLED
            FeatureAuthenticationStatus.SECURITY_UPDATE_REQUIRED -> AndroidAuthenticatorStatus.SECURITY_UPDATE_REQUIRED
            FeatureAuthenticationStatus.UNSUPPORTED_OS_VERSION -> AndroidAuthenticatorStatus.UNSUPPORTED_OSVERSION
            FeatureAuthenticationStatus.UNKNOWN -> AndroidAuthenticatorStatus.UNKNOWN
            null -> AndroidAuthenticatorStatus.UNKNOWN
        }
    }

    override fun checkSecureAuthenticatorStatus(): AndroidAuthenticatorStatus {
        val authenticatorStatus =
            featureAuthentication?.checkSecureAuthentication()
        return when (authenticatorStatus) {
            FeatureAuthenticationStatus.SUCCESS -> AndroidAuthenticatorStatus.SUCCESS
            FeatureAuthenticationStatus.NO_HARDWARE -> AndroidAuthenticatorStatus.NO_HARDWARE_AVAILABLE
            FeatureAuthenticationStatus.UNAVAILABLE -> AndroidAuthenticatorStatus.UNAVAILABLE
            FeatureAuthenticationStatus.NONE_ENROLLED -> AndroidAuthenticatorStatus.NONE_ENROLLED
            FeatureAuthenticationStatus.SECURITY_UPDATE_REQUIRED -> AndroidAuthenticatorStatus.SECURITY_UPDATE_REQUIRED
            FeatureAuthenticationStatus.UNSUPPORTED_OS_VERSION -> AndroidAuthenticatorStatus.UNSUPPORTED_OSVERSION
            FeatureAuthenticationStatus.UNKNOWN -> AndroidAuthenticatorStatus.UNKNOWN
            null -> AndroidAuthenticatorStatus.UNKNOWN
        }
    }

    override fun canAuthenticate(
        androidAuthenticatorType: AndroidAuthenticatorType,
    ): Boolean =
        checkAuthenticatorStatus(androidAuthenticatorType) == AndroidAuthenticatorStatus.SUCCESS

    @RequiresApi(Build.VERSION_CODES.R)
    override fun authenticateDeviceCredential(
        title: String,
        subTitle: String?,
        description: String,
        negativeText: String,
        confirmationRequired: Boolean,
        callback: (Result<AndroidAuthenticationResult>) -> Unit
    ) {
        featureAuthentication?.authenticateDeviceCredential(
            title = title,
            subTitle = subTitle,
            description = description,
            negativeText = negativeText,
            confirmationRequired = confirmationRequired,
            callBack = object : AuthenticationCallBack {
                override fun onSuccessAuthenticate() {
                    callback.invoke(
                        Result.success(
                            AndroidAuthenticationResult(
                                status = AndroidAuthenticationResultStatus.SUCCESS
                            )
                        )
                    )
                }

                override fun onFailedAuthenticate() {
                    callback.invoke(
                        Result.success(
                            AndroidAuthenticationResult(
                                status = AndroidAuthenticationResultStatus.FAILED
                            )
                        )
                    )
                }

                override fun onErrorAuthenticate(exception: FeatureIdentityException) {
                    callback.invoke(
                        Result.success(
                            AndroidAuthenticationResult(
                                status = AndroidAuthenticationResultStatus.ERROR,
                                failure = AndroidAuthenticationFailure(
                                    code = exception.code,
                                    message = exception.message,
                                )
                            )
                        )
                    )
                }

                override fun onNegativeButtonClicked(which: Int) {
                    callback.invoke(
                        Result.success(
                            AndroidAuthenticationResult(
                                status = AndroidAuthenticationResultStatus.NEGATIVE_BUTTON_CLICKED,
                                negativeButtonClickResult = AndroidAuthenticationNegativeButtonClickResult(
                                    which.toLong()
                                )
                            )
                        )
                    )
                }

                override fun onCanceled() {
                    super.onCanceled()
                    callback.invoke(
                        Result.success(
                            AndroidAuthenticationResult(
                                status = AndroidAuthenticationResultStatus.CANCELED
                            )
                        )
                    )
                }
            }
        )
    }

    override fun authenticateBiometric(
        title: String,
        subTitle: String?,
        description: String,
        negativeText: String,
        confirmationRequired: Boolean,
        callback: (Result<AndroidAuthenticationResult>) -> Unit
    ) {
        featureAuthentication?.authenticateBiometric(
            title = title,
            subTitle = subTitle,
            description = description,
            negativeText = negativeText,
            confirmationRequired = confirmationRequired,
            callBack = object : AuthenticationCallBack {
                override fun onSuccessAuthenticate() {
                    callback.invoke(
                        Result.success(
                            AndroidAuthenticationResult(
                                status = AndroidAuthenticationResultStatus.SUCCESS
                            )
                        )
                    )
                }

                override fun onFailedAuthenticate() {
                    callback.invoke(
                        Result.success(
                            AndroidAuthenticationResult(
                                status = AndroidAuthenticationResultStatus.FAILED
                            )
                        )
                    )
                }

                override fun onErrorAuthenticate(exception: FeatureIdentityException) {
                    callback.invoke(
                        Result.success(
                            AndroidAuthenticationResult(
                                status = AndroidAuthenticationResultStatus.ERROR,
                                failure = AndroidAuthenticationFailure(
                                    code = exception.code,
                                    message = exception.message,
                                )
                            )
                        )
                    )
                }

                override fun onNegativeButtonClicked(which: Int) {
                    callback.invoke(
                        Result.success(
                            AndroidAuthenticationResult(
                                status = AndroidAuthenticationResultStatus.NEGATIVE_BUTTON_CLICKED,
                                negativeButtonClickResult = AndroidAuthenticationNegativeButtonClickResult(
                                    which.toLong()
                                )
                            )
                        )
                    )
                }

                override fun onCanceled() {
                    super.onCanceled()
                    callback.invoke(
                        Result.success(
                            AndroidAuthenticationResult(
                                status = AndroidAuthenticationResultStatus.CANCELED
                            )
                        )
                    )
                }
            }
        )
    }

    override fun isBiometricChanged(alias: String): Boolean {
        return featureAuthentication?.isBiometricChanged(alias) ?: throw FeatureIdentityException(
            code = "FEATURE_AUTHENTICATION_MISSING"
        )
    }

    override fun authenticateBiometricSecureEncrypt(
        alias: String,
        requestForEncrypt: Map<String, String>,
        title: String,
        subTitle: String?,
        description: String,
        negativeText: String,
        confirmationRequired: Boolean,
        callback: (Result<AndroidSecureEncryptAuthResult>) -> Unit
    ) {
        featureAuthentication?.secureAuthenticateBiometricEncrypt(
            title = title,
            subTitle = subTitle,
            description = description,
            negativeText = negativeText,
            confirmationRequired = confirmationRequired,
            alias = alias,
            callBack = object : SecureAuthenticationEncryptCallBack {
                override fun onSuccessAuthenticate(
                    cipher: Cipher,
                    encodedIVKey: String
                ) {
                    val encryptedResponse: HashMap<String, String?> = hashMapOf()
                    requestForEncrypt.forEach { it ->
                        encryptedResponse[it.key] =
                            featureAuthentication?.encrypt(cipher, it.value)
                    }
                    callback.invoke(
                        Result.success(
                            AndroidSecureEncryptAuthResult(
                                status = AndroidAuthenticationResultStatus.SUCCESS,
                                encodedIVKey = encodedIVKey,
                                encryptedResult = encryptedResponse
                            )
                        )
                    )
                }

                override fun onErrorAuthenticate(exception: FeatureIdentityException) {
                    callback.invoke(
                        Result.success(
                            AndroidSecureEncryptAuthResult(
                                status = AndroidAuthenticationResultStatus.ERROR,
                                failure = AndroidAuthenticationFailure(
                                    code = exception.code,
                                    message = exception.message,
                                )
                            )
                        )
                    )
                }

                override fun onFailedAuthenticate() {
                    callback.invoke(
                        Result.success(
                            AndroidSecureEncryptAuthResult(
                                status = AndroidAuthenticationResultStatus.FAILED,
                            )
                        )
                    )
                }

                override fun onNegativeButtonClicked(which: Int) {
                    callback.invoke(
                        Result.success(
                            AndroidSecureEncryptAuthResult(
                                status = AndroidAuthenticationResultStatus.NEGATIVE_BUTTON_CLICKED,
                                negativeButtonClickResult = AndroidAuthenticationNegativeButtonClickResult(
                                    which.toLong()
                                )
                            )
                        )
                    )
                }

                override fun onCanceled() {
                    super.onCanceled()
                    callback.invoke(
                        Result.success(
                            AndroidSecureEncryptAuthResult(
                                status = AndroidAuthenticationResultStatus.CANCELED
                            )
                        )
                    )
                }
            }
        )
    }

    override fun authenticateBiometricSecureDecrypt(
        alias: String,
        encodedIVKey: String,
        requestForDecrypt: Map<String, String>,
        title: String,
        subTitle: String?,
        description: String,
        negativeText: String,
        confirmationRequired: Boolean,
        callback: (Result<AndroidSecureDecryptAuthResult>) -> Unit
    ) {
        featureAuthentication?.secureAuthenticateBiometricDecrypt(
            encodedIVKey = encodedIVKey,
            title = title,
            subTitle = subTitle,
            description = description,
            negativeText = negativeText,
            confirmationRequired = confirmationRequired,
            alias = alias,
            callBack = object : SecureAuthenticationDecryptCallBack {
                override fun onSuccessAuthenticate(cipher: Cipher) {
                    val decryptedResponse: HashMap<String, String?> = hashMapOf()
                    requestForDecrypt.forEach { it ->
                        val decoded = Base64.decode(it.value, Base64.NO_WRAP)
                        val decrypted = featureAuthentication?.decrypt(cipher, decoded)
                        decryptedResponse[it.key] = decrypted

                    }
                    callback.invoke(
                        Result.success(
                            AndroidSecureDecryptAuthResult(
                                status = AndroidAuthenticationResultStatus.SUCCESS,
                                decryptedResult = decryptedResponse,
                            )
                        )
                    )
                }

                override fun onErrorAuthenticate(exception: FeatureIdentityException) {
                    callback.invoke(
                        Result.success(
                            AndroidSecureDecryptAuthResult(
                                status = AndroidAuthenticationResultStatus.ERROR,
                                failure = AndroidAuthenticationFailure(
                                    code = exception.code,
                                    message = exception.message,
                                )
                            )
                        )
                    )
                }

                override fun onFailedAuthenticate() {
                    callback.invoke(
                        Result.success(
                            AndroidSecureDecryptAuthResult(
                                status = AndroidAuthenticationResultStatus.FAILED,
                            )
                        )
                    )
                }

                override fun onNegativeButtonClicked(which: Int) {
                    callback.invoke(
                        Result.success(
                            AndroidSecureDecryptAuthResult(
                                status = AndroidAuthenticationResultStatus.NEGATIVE_BUTTON_CLICKED,
                                negativeButtonClickResult = AndroidAuthenticationNegativeButtonClickResult(
                                    which.toLong()
                                )
                            )
                        )
                    )
                }

                override fun onCanceled() {
                    super.onCanceled()
                    callback.invoke(
                        Result.success(
                            AndroidSecureDecryptAuthResult(
                                status = AndroidAuthenticationResultStatus.CANCELED
                            )
                        )
                    )
                }
            }
        )
    }
}
