package com.mawistudios.trainer.trainer.data.observer

import com.mawistudios.trainer.trainer.model.Sensor
import com.mawistudios.trainer.trainer.model.SensorData

interface ITrainingSessionObserver {
    fun onNewSensorData(sensorData: SensorData)
    fun onDiscoveryStarted()
    fun onSensorConnectionStateChanged(
            sensor: Sensor
    )
}