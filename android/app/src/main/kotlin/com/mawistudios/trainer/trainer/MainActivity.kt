package com.mawistudios.trainer.trainer

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.ServiceConnection
import android.os.Bundle
import android.os.IBinder
import android.os.PersistableBundle
import com.google.gson.Gson
import com.mawistudios.trainer.trainer.app.log
import com.mawistudios.trainer.trainer.app.toast
import com.mawistudios.trainer.trainer.data.observer.ITrainingSessionObserver
import com.mawistudios.trainer.trainer.data.SensorService
import com.mawistudios.trainer.trainer.data.observer.TrainingSessionObservable
import com.mawistudios.trainer.trainer.model.Sensor
import com.mawistudios.trainer.trainer.model.SensorData
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private lateinit var channel: MethodChannel

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        setupChannelCallHandler(flutterEngine)
    }

    private fun setupChannelCallHandler(flutterEngine: FlutterEngine) {
        val binaryMessenger = flutterEngine.dartExecutor.binaryMessenger
        channel = MethodChannel(binaryMessenger, "com.mawistudios.trainer/sensor")
        channel.setMethodCallHandler { call, result ->
            onMethodCall(call, result)
        }
    }

    private lateinit var sensorService: SensorService

    private val connection = object : ServiceConnection {
        override fun onServiceConnected(className: ComponentName, service: IBinder) {
            log("Service connected")
            val binder = service as SensorService.LocalBinder
            sensorService = binder.getService()
        }

        override fun onServiceDisconnected(arg0: ComponentName) {
            log("Service disconnected")
        }
    }

    private var isServiceBound: Boolean = false

    private fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startService" -> {
                log("Service startet")
                sensorService.startDiscovery()
            }
            else -> throw Error("Method: ${call.method} is not implemented.")
        }
    }

    override fun onStart() {
        super.onStart()
        TrainingSessionObservable.register(trainingSessionObserver)
        Intent(this, SensorService::class.java).also {
            bindService(it, connection, Context.BIND_AUTO_CREATE)
            isServiceBound = true
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        if (isServiceBound) {
            sensorService.stopDiscovery()
            unbindService(connection)
        }
    }

    override fun onStop() {
        super.onStop()
        TrainingSessionObservable.unRegister(trainingSessionObserver)
    }

    private val trainingSessionObserver = object : ITrainingSessionObserver {
        override fun onNewSensorData(sensorData: SensorData) {
            toast("new sensor data: $sensorData ")
            channel.invokeMethod("onNewSensorData", Gson().toJson(sensorData))
        }

        override fun onDiscoveryStarted() {
            toast("discovery started")
        }

        override fun onSensorConnectionStateChanged(sensor: Sensor) {
            toast("sensor status changed: ${sensor.name}")
            channel.invokeMethod("onSensorConnectionStateChanged", Gson().toJson(sensor))
        }
    }
}

