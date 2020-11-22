package com.mawistudios.trainer.trainer

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    private val channels: MutableList<Channel> = mutableListOf()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        registerChannels(flutterEngine)
    }

    private fun registerChannels(flutterEngine: FlutterEngine) {
        channels.add(SensorChannel(flutterEngine))
    }
}

