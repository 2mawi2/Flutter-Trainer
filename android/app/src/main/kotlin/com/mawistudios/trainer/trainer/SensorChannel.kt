package com.mawistudios.trainer.trainer

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class SensorChannel(flutterEngine: FlutterEngine) : Channel(
        flutterEngine,
        "com.mawistudios.trainer/sensor"
) {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) = when (call.method) {
        "startService" -> {
            println("start Service was invoked in Android!")
            result.success("successful")
        }
        else -> onMethodNotFound(call.method)
    }
}