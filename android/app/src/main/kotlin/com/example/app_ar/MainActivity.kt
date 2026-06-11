package com.example.app_ar

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channelName = "app_ar/unity"
    private val cameraPermissionRequestCode = 4021
    private var pendingUnityResult: MethodChannel.Result? = null
    private var pendingModelId: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "openUnityAr" -> {
                        val modelId = call.argument<String>("modelId")
                        openUnityAr(modelId, result)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun openUnityAr(modelId: String?, result: MethodChannel.Result) {
        if (checkSelfPermission(Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
            if (pendingUnityResult != null) {
                result.error(
                    "AR_LAUNCH_PENDING",
                    "AR is already waiting for camera permission.",
                    null,
                )
                return
            }

            pendingUnityResult = result
            pendingModelId = modelId
            requestPermissions(
                arrayOf(Manifest.permission.CAMERA),
                cameraPermissionRequestCode,
            )
            return
        }

        startUnityActivity(modelId, result)
    }

    private fun startUnityActivity(modelId: String?, result: MethodChannel.Result) {
        try {
            val unityActivity = Class.forName("com.unity3d.player.UnityPlayerGameActivity")
            val intent = Intent(this, unityActivity).apply {
                modelId?.let { putExtra("modelId", it) }
            }
            startActivity(intent)
            result.success(null)
        } catch (error: ClassNotFoundException) {
            result.error(
                "UNITY_ACTIVITY_NOT_FOUND",
                "Unity AR activity is not available in this build.",
                null,
            )
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        if (requestCode != cameraPermissionRequestCode) return

        val result = pendingUnityResult ?: return
        val modelId = pendingModelId
        pendingUnityResult = null
        pendingModelId = null

        if (grantResults.firstOrNull() == PackageManager.PERMISSION_GRANTED) {
            startUnityActivity(modelId, result)
        } else {
            result.error(
                "CAMERA_PERMISSION_DENIED",
                "Camera permission is required to use AR.",
                null,
            )
        }
    }
}
