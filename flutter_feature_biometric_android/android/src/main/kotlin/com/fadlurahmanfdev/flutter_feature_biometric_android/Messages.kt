// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v22.4.0), do not edit directly.
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

enum class NativeBiometricType(val raw: Int) {
  WEAK(0),
  STRONG(1),
  DEVICE_CREDENTIAL(2);

  companion object {
    fun ofRaw(raw: Int): NativeBiometricType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class NativeAndroidBiometricStatus(val raw: Int) {
  SUCCESS(0),
  NO_BIOMETRIC_AVAILABLE(1),
  UNAVAILABLE(2),
  NONE_ENROLLED(3),
  UNKNOWN(4);

  companion object {
    fun ofRaw(raw: Int): NativeAndroidBiometricStatus? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}
private open class MessagesPigeonCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      129.toByte() -> {
        return (readValue(buffer) as Long?)?.let {
          NativeBiometricType.ofRaw(it.toInt())
        }
      }
      130.toByte() -> {
        return (readValue(buffer) as Long?)?.let {
          NativeAndroidBiometricStatus.ofRaw(it.toInt())
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is NativeBiometricType -> {
        stream.write(129)
        writeValue(stream, value.raw)
      }
      is NativeAndroidBiometricStatus -> {
        stream.write(130)
        writeValue(stream, value.raw)
      }
      else -> super.writeValue(stream, value)
    }
  }
}


/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface HostFeatureBiometricApi {
  fun haveFeatureBiometric(): Boolean
  fun haveFaceDetection(): Boolean
  fun canAuthenticate(authenticator: NativeBiometricType): Boolean
  fun checkBiometricStatus(type: NativeBiometricType): NativeAndroidBiometricStatus
  fun authenticate(type: NativeBiometricType, title: String, description: String, negativeText: String, callback: (Result<String>) -> Unit)

  companion object {
    /** The codec used by HostFeatureBiometricApi. */
    val codec: MessageCodec<Any?> by lazy {
      MessagesPigeonCodec()
    }
    /** Sets up an instance of `HostFeatureBiometricApi` to handle messages through the `binaryMessenger`. */
    @JvmOverloads
    fun setUp(binaryMessenger: BinaryMessenger, api: HostFeatureBiometricApi?, messageChannelSuffix: String = "") {
      val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.HostFeatureBiometricApi.haveFeatureBiometric$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped: List<Any?> = try {
              listOf(api.haveFeatureBiometric())
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
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.HostFeatureBiometricApi.haveFaceDetection$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped: List<Any?> = try {
              listOf(api.haveFaceDetection())
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
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.HostFeatureBiometricApi.canAuthenticate$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val authenticatorArg = args[0] as NativeBiometricType
            val wrapped: List<Any?> = try {
              listOf(api.canAuthenticate(authenticatorArg))
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
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.HostFeatureBiometricApi.checkBiometricStatus$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val typeArg = args[0] as NativeBiometricType
            val wrapped: List<Any?> = try {
              listOf(api.checkBiometricStatus(typeArg))
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
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_feature_biometric_android.HostFeatureBiometricApi.authenticate$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val typeArg = args[0] as NativeBiometricType
            val titleArg = args[1] as String
            val descriptionArg = args[2] as String
            val negativeTextArg = args[3] as String
            api.authenticate(typeArg, titleArg, descriptionArg, negativeTextArg) { result: Result<String> ->
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
