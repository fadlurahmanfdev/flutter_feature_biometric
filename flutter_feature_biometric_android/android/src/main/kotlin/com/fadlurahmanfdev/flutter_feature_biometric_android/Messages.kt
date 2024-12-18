// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v22.5.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
@file:Suppress("UNCHECKED_CAST", "ArrayInDataClass")

package com.fadlurahmanfdev.flutter_feature_biometric_android

import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  return if (exception is FlutterError) {
    listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

enum class AndroidAuthenticatorStatus(val raw: Int) {
  SUCCESS(0),
  NO_HARDWARE_AVAILABLE(1),
  UNAVAILABLE(2),
  NONE_ENROLLED(3),
  SECURITY_UPDATE_REQUIRED(4),
  UNSUPPORTED_OSVERSION(5),
  UNKNOWN(6);

  companion object {
    fun ofRaw(raw: Int): AndroidAuthenticatorStatus? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class AndroidAuthenticatorType(val raw: Int) {
  BIOMETRIC(0),
  DEVICE_CREDENTIAL(1);

  companion object {
    fun ofRaw(raw: Int): AndroidAuthenticatorType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class AndroidAuthenticationResultStatus(val raw: Int) {
  SUCCESS(0),
  CANCELED(1),
  FAILED(2),
  ERROR(3),
  NEGATIVE_BUTTON_CLICKED(4);

  companion object {
    fun ofRaw(raw: Int): AndroidAuthenticationResultStatus? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class AndroidAuthenticationFailure (
  val code: String,
  val message: String? = null
)
 {
  companion object {
    fun fromList(pigeonVar_list: List<Any?>): AndroidAuthenticationFailure {
      val code = pigeonVar_list[0] as String
      val message = pigeonVar_list[1] as String?
      return AndroidAuthenticationFailure(code, message)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      code,
      message,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class AndroidAuthenticationNegativeButtonClickResult (
  val which: Long
)
 {
  companion object {
    fun fromList(pigeonVar_list: List<Any?>): AndroidAuthenticationNegativeButtonClickResult {
      val which = pigeonVar_list[0] as Long
      return AndroidAuthenticationNegativeButtonClickResult(which)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      which,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class AndroidAuthenticationResult (
  val status: AndroidAuthenticationResultStatus,
  val failure: AndroidAuthenticationFailure? = null,
  val negativeButtonClickResult: AndroidAuthenticationNegativeButtonClickResult? = null
)
 {
  companion object {
    fun fromList(pigeonVar_list: List<Any?>): AndroidAuthenticationResult {
      val status = pigeonVar_list[0] as AndroidAuthenticationResultStatus
      val failure = pigeonVar_list[1] as AndroidAuthenticationFailure?
      val negativeButtonClickResult = pigeonVar_list[2] as AndroidAuthenticationNegativeButtonClickResult?
      return AndroidAuthenticationResult(status, failure, negativeButtonClickResult)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      status,
      failure,
      negativeButtonClickResult,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class AndroidSecureEncryptAuthResult (
  val status: AndroidAuthenticationResultStatus,
  val encodedIVKey: String? = null,
  val encryptedResult: Map<String, String?>? = null,
  val failure: AndroidAuthenticationFailure? = null,
  val negativeButtonClickResult: AndroidAuthenticationNegativeButtonClickResult? = null
)
 {
  companion object {
    fun fromList(pigeonVar_list: List<Any?>): AndroidSecureEncryptAuthResult {
      val status = pigeonVar_list[0] as AndroidAuthenticationResultStatus
      val encodedIVKey = pigeonVar_list[1] as String?
      val encryptedResult = pigeonVar_list[2] as Map<String, String?>?
      val failure = pigeonVar_list[3] as AndroidAuthenticationFailure?
      val negativeButtonClickResult = pigeonVar_list[4] as AndroidAuthenticationNegativeButtonClickResult?
      return AndroidSecureEncryptAuthResult(status, encodedIVKey, encryptedResult, failure, negativeButtonClickResult)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      status,
      encodedIVKey,
      encryptedResult,
      failure,
      negativeButtonClickResult,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class AndroidSecureDecryptAuthResult (
  val status: AndroidAuthenticationResultStatus,
  val decryptedResult: Map<String, String?>? = null,
  val failure: AndroidAuthenticationFailure? = null,
  val negativeButtonClickResult: AndroidAuthenticationNegativeButtonClickResult? = null
)
 {
  companion object {
    fun fromList(pigeonVar_list: List<Any?>): AndroidSecureDecryptAuthResult {
      val status = pigeonVar_list[0] as AndroidAuthenticationResultStatus
      val decryptedResult = pigeonVar_list[1] as Map<String, String?>?
      val failure = pigeonVar_list[2] as AndroidAuthenticationFailure?
      val negativeButtonClickResult = pigeonVar_list[3] as AndroidAuthenticationNegativeButtonClickResult?
      return AndroidSecureDecryptAuthResult(status, decryptedResult, failure, negativeButtonClickResult)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      status,
      decryptedResult,
      failure,
      negativeButtonClickResult,
    )
  }
}
private open class MessagesPigeonCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      129.toByte() -> {
        return (readValue(buffer) as Long?)?.let {
          AndroidAuthenticatorStatus.ofRaw(it.toInt())
        }
      }
      130.toByte() -> {
        return (readValue(buffer) as Long?)?.let {
          AndroidAuthenticatorType.ofRaw(it.toInt())
        }
      }
      131.toByte() -> {
        return (readValue(buffer) as Long?)?.let {
          AndroidAuthenticationResultStatus.ofRaw(it.toInt())
        }
      }
      132.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          AndroidAuthenticationFailure.fromList(it)
        }
      }
      133.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          AndroidAuthenticationNegativeButtonClickResult.fromList(it)
        }
      }
      134.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          AndroidAuthenticationResult.fromList(it)
        }
      }
      135.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          AndroidSecureEncryptAuthResult.fromList(it)
        }
      }
      136.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          AndroidSecureDecryptAuthResult.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is AndroidAuthenticatorStatus -> {
        stream.write(129)
        writeValue(stream, value.raw)
      }
      is AndroidAuthenticatorType -> {
        stream.write(130)
        writeValue(stream, value.raw)
      }
      is AndroidAuthenticationResultStatus -> {
        stream.write(131)
        writeValue(stream, value.raw)
      }
      is AndroidAuthenticationFailure -> {
        stream.write(132)
        writeValue(stream, value.toList())
      }
      is AndroidAuthenticationNegativeButtonClickResult -> {
        stream.write(133)
        writeValue(stream, value.toList())
      }
      is AndroidAuthenticationResult -> {
        stream.write(134)
        writeValue(stream, value.toList())
      }
      is AndroidSecureEncryptAuthResult -> {
        stream.write(135)
        writeValue(stream, value.toList())
      }
      is AndroidSecureDecryptAuthResult -> {
        stream.write(136)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}


/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface FlutterFeatureBiometricApi {
  fun deleteSecretKey(alias: String)
  fun isDeviceSupportFingerprint(): Boolean
  fun isDeviceSupportFaceAuth(): Boolean
  fun isDeviceSupportBiometric(): Boolean
  fun isFingerprintEnrolled(): Boolean
  fun isDeviceCredentialEnrolled(): Boolean
  fun checkAuthenticatorStatus(androidAuthenticatorType: AndroidAuthenticatorType): AndroidAuthenticatorStatus
  fun checkSecureAuthenticatorStatus(): AndroidAuthenticatorStatus
  fun canAuthenticate(androidAuthenticatorType: AndroidAuthenticatorType): Boolean
  fun authenticateDeviceCredential(title: String, subTitle: String?, description: String, negativeText: String, confirmationRequired: Boolean, callback: (Result<AndroidAuthenticationResult>) -> Unit)
  fun authenticateBiometric(title: String, subTitle: String?, description: String, negativeText: String, confirmationRequired: Boolean, callback: (Result<AndroidAuthenticationResult>) -> Unit)
  fun isBiometricChanged(alias: String): Boolean
  fun authenticateBiometricSecureEncrypt(alias: String, requestForEncrypt: Map<String, String>, title: String, subTitle: String?, description: String, negativeText: String, confirmationRequired: Boolean, callback: (Result<AndroidSecureEncryptAuthResult>) -> Unit)
  fun authenticateBiometricSecureDecrypt(alias: String, encodedIVKey: String, requestForDecrypt: Map<String, String>, title: String, subTitle: String?, description: String, negativeText: String, confirmationRequired: Boolean, callback: (Result<AndroidSecureDecryptAuthResult>) -> Unit)

  companion object {
    /** The codec used by FlutterFeatureBiometricApi. */
    val codec: MessageCodec<Any?> by lazy {
      MessagesPigeonCodec()
    }
    /** Sets up an instance of `FlutterFeatureBiometricApi` to handle messages through the `binaryMessenger`. */
    @JvmOverloads
    fun setUp(binaryMessenger: BinaryMessenger, api: FlutterFeatureBiometricApi?, messageChannelSuffix: String = "") {
      val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.deleteSecretKey$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val aliasArg = args[0] as String
            val wrapped: List<Any?> = try {
              api.deleteSecretKey(aliasArg)
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.isDeviceSupportFingerprint$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped: List<Any?> = try {
              listOf(api.isDeviceSupportFingerprint())
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.isDeviceSupportFaceAuth$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped: List<Any?> = try {
              listOf(api.isDeviceSupportFaceAuth())
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.isDeviceSupportBiometric$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped: List<Any?> = try {
              listOf(api.isDeviceSupportBiometric())
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.isFingerprintEnrolled$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped: List<Any?> = try {
              listOf(api.isFingerprintEnrolled())
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.isDeviceCredentialEnrolled$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped: List<Any?> = try {
              listOf(api.isDeviceCredentialEnrolled())
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.checkAuthenticatorStatus$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val androidAuthenticatorTypeArg = args[0] as AndroidAuthenticatorType
            val wrapped: List<Any?> = try {
              listOf(api.checkAuthenticatorStatus(androidAuthenticatorTypeArg))
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.checkSecureAuthenticatorStatus$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped: List<Any?> = try {
              listOf(api.checkSecureAuthenticatorStatus())
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.canAuthenticate$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val androidAuthenticatorTypeArg = args[0] as AndroidAuthenticatorType
            val wrapped: List<Any?> = try {
              listOf(api.canAuthenticate(androidAuthenticatorTypeArg))
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.authenticateDeviceCredential$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val titleArg = args[0] as String
            val subTitleArg = args[1] as String?
            val descriptionArg = args[2] as String
            val negativeTextArg = args[3] as String
            val confirmationRequiredArg = args[4] as Boolean
            api.authenticateDeviceCredential(titleArg, subTitleArg, descriptionArg, negativeTextArg, confirmationRequiredArg) { result: Result<AndroidAuthenticationResult> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.authenticateBiometric$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val titleArg = args[0] as String
            val subTitleArg = args[1] as String?
            val descriptionArg = args[2] as String
            val negativeTextArg = args[3] as String
            val confirmationRequiredArg = args[4] as Boolean
            api.authenticateBiometric(titleArg, subTitleArg, descriptionArg, negativeTextArg, confirmationRequiredArg) { result: Result<AndroidAuthenticationResult> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.isBiometricChanged$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val aliasArg = args[0] as String
            val wrapped: List<Any?> = try {
              listOf(api.isBiometricChanged(aliasArg))
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.authenticateBiometricSecureEncrypt$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val aliasArg = args[0] as String
            val requestForEncryptArg = args[1] as Map<String, String>
            val titleArg = args[2] as String
            val subTitleArg = args[3] as String?
            val descriptionArg = args[4] as String
            val negativeTextArg = args[5] as String
            val confirmationRequiredArg = args[6] as Boolean
            api.authenticateBiometricSecureEncrypt(aliasArg, requestForEncryptArg, titleArg, subTitleArg, descriptionArg, negativeTextArg, confirmationRequiredArg) { result: Result<AndroidSecureEncryptAuthResult> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.FlutterFeatureBiometricApi.authenticateBiometricSecureDecrypt$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val aliasArg = args[0] as String
            val encodedIVKeyArg = args[1] as String
            val requestForDecryptArg = args[2] as Map<String, String>
            val titleArg = args[3] as String
            val subTitleArg = args[4] as String?
            val descriptionArg = args[5] as String
            val negativeTextArg = args[6] as String
            val confirmationRequiredArg = args[7] as Boolean
            api.authenticateBiometricSecureDecrypt(aliasArg, encodedIVKeyArg, requestForDecryptArg, titleArg, subTitleArg, descriptionArg, negativeTextArg, confirmationRequiredArg) { result: Result<AndroidSecureDecryptAuthResult> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
