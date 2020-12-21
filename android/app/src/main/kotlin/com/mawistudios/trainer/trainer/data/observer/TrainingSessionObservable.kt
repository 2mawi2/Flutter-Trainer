package com.mawistudios.trainer.trainer.data.observer

import com.mawistudios.trainer.trainer.model.Sensor
import com.mawistudios.trainer.trainer.model.SensorData

object TrainingSessionObservable {
    private var observers = mutableListOf<ITrainingSessionObserver>()

    fun register(trainingSessionObserver: ITrainingSessionObserver) {
        observers.add(trainingSessionObserver)
    }

    fun unRegister(trainingSessionObserver: ITrainingSessionObserver) {
        observers.removeIf { it == trainingSessionObserver }
    }

    fun onNewSensorData(sensorData: SensorData) = observers.forEach { it.onNewSensorData(sensorData) }

    fun onDiscoveryStarted() = observers.forEach { it.onDiscoveryStarted() }

    fun onSensorConnectionStateChanged(
            sensor: Sensor
    ) {
        observers.forEach { it.onSensorConnectionStateChanged(sensor) }
    }
}