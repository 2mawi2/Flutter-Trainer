package com.mawistudios.trainer.trainer.data

import android.app.Service
import android.content.Intent
import android.os.Binder
import android.os.IBinder
import com.mawistudios.trainer.trainer.app.log
import com.mawistudios.trainer.trainer.data.sensors.SensorManager
import com.mawistudios.trainer.trainer.model.Sensor

class SensorService : Service() {
    private lateinit var hardwareManager: IHardwareManager

    private var isDiscovering = false

    override fun onCreate() {
        super.onCreate()
        val sensorManager = SensorManager()
        hardwareManager = HardwareManager(this, sensorManager)
    }

    fun startDiscovery() {
        log("Starting discovery")
        hardwareManager.discover()
        isDiscovering = true
    }

    fun stopDiscovery() {
        if (!isDiscovering) return
        log("Stopping discovery")
        hardwareManager.stopDiscovering()
        isDiscovering = false
    }

    inner class LocalBinder : Binder() {
        fun getService(): SensorService = this@SensorService
    }

    private val binder = LocalBinder()

    override fun onBind(intent: Intent?): IBinder? {
        return binder
    }

    override fun onDestroy() {
        super.onDestroy()
        hardwareManager.shutdown()
    }

    fun connectDevice(sensor: Sensor) {
        hardwareManager.connectDevice(sensor)
    }
}
