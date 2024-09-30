package com.fadlurahmanfdev.flutter_feature_biometric_android

import android.app.Activity
import com.fadlurahmanfdev.kotlin_feature_identity.plugin.KotlinFeatureBiometric
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** FlutterFeatureBiometricAndroidPlugin */
class FlutterFeatureBiometricAndroidPlugin : FlutterPlugin, ActivityAware,
    FlutterFeatureBiometricApi {
    var activity: Activity? = null
    lateinit var kotlinFeatureBiometric: KotlinFeatureBiometric

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        FlutterFeatureBiometricApi.setUp(flutterPluginBinding.getBinaryMessenger(), this)
        kotlinFeatureBiometric = KotlinFeatureBiometric(activity!!)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        FlutterFeatureBiometricApi.setUp(binding.getBinaryMessenger(), null)
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

    override fun isDeviceSupportBiometric(): Boolean {
        return kotlinFeatureBiometric.haveFeatureBiometric()
    }
}
