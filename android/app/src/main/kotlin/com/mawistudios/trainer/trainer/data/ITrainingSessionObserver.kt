package com.mawistudios.trainer.trainer.data

import com.mawistudios.trainer.trainer.model.Sensor

interface ITrainingSessionObserver {
    fun onTrainingDataChanged()
    fun onDiscoveryStarted()
    fun onSensorConnectionStateChanged(
        sensor: Sensor
    )
}