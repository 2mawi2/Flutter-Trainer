package com.mawistudios.trainer.trainer

import android.Manifest
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.ServiceConnection
import android.content.pm.PackageManager
import android.os.Bundle
import android.os.IBinder
import android.os.PersistableBundle
import androidx.core.content.ContextCompat
import com.google.gson.Gson
import com.mawistudios.trainer.trainer.app.log
import com.mawistudios.trainer.trainer.app.toast
import com.mawistudios.trainer.trainer.data.SensorService
import com.mawistudios.trainer.trainer.data.observer.ITrainingSessionObserver
import com.mawistudios.trainer.trainer.data.observer.TrainingSessionObservable
import com.mawistudios.trainer.trainer.model.Sensor
import com.mawistudios.trainer.trainer.model.SensorData
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlin.coroutines.CoroutineContext

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
        ensureLocationPermission()
        ensureBluetoothLowEnergyPermission()
        TrainingSessionObservable.register(trainingSessionObserver)
        Intent(this, SensorService::class.java).also {
            bindService(it, connection, Context.BIND_AUTO_CREATE)
            isServiceBound = true
        }
    }


    private val REQUEST_LOCATION = 777
    private fun ensureLocationPermission() {
        when {
            ContextCompat.checkSelfPermission(
                    this.context,
                    Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED -> {
                log("Location permissions available")
            }
            shouldShowRequestPermissionRationale(Manifest.permission.ACCESS_FINE_LOCATION) -> {
                toast("Please allow location permission!")
            }
            else -> {
                requestPermissions(arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), REQUEST_LOCATION)
            }
        }
    }

    private val REQUEST_ENABLE_BT = 666
    private fun ensureBluetoothLowEnergyPermission() {
        val bluetoothManager = getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
        val bluetoothAdapter = bluetoothManager.adapter
        if (bluetoothAdapter == null || !bluetoothAdapter.isEnabled) {
            val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
            startActivityForResult(enableBtIntent, REQUEST_ENABLE_BT)
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
            GlobalScope.launch(Dispatchers.Main) {
                channel.invokeMethod("onNewSensorData", Gson().toJson(sensorData))
            }
        }

        override fun onDiscoveryStarted() {
            toast("discovery started")
        }

        override fun onSensorConnectionStateChanged(sensor: Sensor) {
            GlobalScope.launch(Dispatchers.Main) {
                channel.invokeMethod("onSensorConnectionStateChanged", Gson().toJson(sensor))
            }
        }
    }
}

