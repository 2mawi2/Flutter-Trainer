package com.mawistudios.trainer.trainer.data.sensors

import com.mawistudios.trainer.trainer.app.log
import com.mawistudios.trainer.trainer.data.observer.TrainingSessionObservable
import com.mawistudios.trainer.trainer.model.Sensor
import com.wahoofitness.connector.HardwareConnectorEnums.SensorConnectionError
import com.wahoofitness.connector.HardwareConnectorEnums.SensorConnectionState
import com.wahoofitness.connector.capabilities.Capability.CapabilityType
import com.wahoofitness.connector.conn.connections.SensorConnection


interface ISensorManager : SensorConnection.Listener {
    override fun onSensorConnectionStateChanged(
            connection: SensorConnection,
            state: SensorConnectionState
    )

    override fun onSensorConnectionError(
            connection: SensorConnection,
            error: SensorConnectionError
    )

    override fun onNewCapabilityDetected(
            connection: SensorConnection,
            type: CapabilityType
    )
}

class SensorManager : ISensorManager {
    override fun onSensorConnectionStateChanged(
            connection: SensorConnection,
            state: SensorConnectionState
    ) {
        log("sensor connection state changed: ${connection.connectionParams.name} $state connection: ${connection.toString()} "
        )

        TrainingSessionObservable.onSensorConnectionStateChanged(
                Sensor(
                        state = state.name,
                        name = connection.deviceName,
                        type = connection.productType.name,
                        params = connection.connectionParams.serialize()
                )
        )
    }

    override fun onSensorConnectionError(
            connection: SensorConnection,
            error: SensorConnectionError
    ) {
        log("sensor connection error")
    }

    override fun onNewCapabilityDetected(
            connection: SensorConnection,
            type: CapabilityType
    ) {
        log("detected sensor: ${type.name}")
        when (type) {
            CapabilityType.Heartrate -> HearthRateSensorStrategy()
            else -> UnknownSensorStrategy()
            // CapabilityType.WheelRevs -> WheelRevsSensorStrategy(sensorDataRepo)
            // CapabilityType.CrankRevs -> CrankRevsSensorStrategy(sensorDataRepo)
            // CapabilityType.BikePower -> BikePowerStrategy(sensorDataRepo)
        }.handleData(connection)
    }
}

