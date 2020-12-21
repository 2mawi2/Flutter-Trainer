package com.mawistudios.trainer.trainer.data.sensors

import com.mawistudios.trainer.trainer.app.log
import com.wahoofitness.connector.conn.connections.SensorConnection

class UnknownSensorStrategy : ICapabilityStrategy {
    override fun handleData(connection: SensorConnection) {
        log("current capabilities ${connection.currentCapabilities}")
    }
}