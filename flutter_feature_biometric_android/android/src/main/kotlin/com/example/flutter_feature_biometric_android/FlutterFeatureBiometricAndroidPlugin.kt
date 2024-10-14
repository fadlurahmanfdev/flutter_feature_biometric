package com.example.flutter_feature_biometric_android

import android.app.Activity
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
    private var kotlinFeatureBiometric: KotlinFeatureBiometric?=null

    private var activity: Activity? = null


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        println("MASUK onAttachedToEngine ${Calendar.getInstance().time}")
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
        println("MASUK onDetachedFromEngine ${Calendar.getInstance().time}")
        channel.setMethodCallHandler(null)
        FlutterFeatureBiometricApi.setUp(binding.binaryMessenger, this)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        println("MASUK onAttachedToActivity ${Calendar.getInstance().time}")
        kotlinFeatureBiometric = KotlinFeatureBiometric(binding.activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        println("MASUK onReattachedToActivityForConfigChanges ${Calendar.getInstance().time}")
        kotlinFeatureBiometric = KotlinFeatureBiometric(binding.activity)
    }

    override fun onDetachedFromActivity() {
        println("MASUK onDetachedFromActivity ${Calendar.getInstance().time}")
        kotlinFeatureBiometric = null
    }

    override fun deviceCanSupportBiometrics(): Boolean {
        val isHaveFeatureBiometric = kotlinFeatureBiometric!!.haveFeatureBiometric()
        println("MASUK deviceCanSupportBiometrics ${Calendar.getInstance().time}")
        println("MASUK deviceCanSupportBiometrics $isHaveFeatureBiometric")
        return isHaveFeatureBiometric
    }
}
