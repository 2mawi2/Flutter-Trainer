package com.mawistudios.trainer.trainer.data.sensors

import com.wahoofitness.connector.conn.connections.SensorConnection

interface ICapabilityStrategy {
    fun handleData(connection: SensorConnection)
}


