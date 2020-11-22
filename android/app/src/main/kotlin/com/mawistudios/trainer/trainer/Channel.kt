package com.mawistudios.trainer.trainer

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

abstract class Channel(private val flutterEngine: FlutterEngine, channel: String) {
    init {
        setMethodCallHandler(channel)
    }

    private fun setMethodCallHandler(channel: String) {
        val binaryMessenger = flutterEngine.dartExecutor.binaryMessenger
        MethodChannel(binaryMessenger, channel).setMethodCallHandler { call, result ->
            onMethodCall(call, result)
        }
    }

    abstract fun onMethodCall(call: MethodCall, result: MethodChannel.Result)

    protected fun onMethodNotFound(method: String) {
        throw Error("Method: $method is not implemented.")
    }
}