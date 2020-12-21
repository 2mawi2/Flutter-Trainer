package com.mawistudios.trainer.trainer.data.sensors

import com.mawistudios.trainer.trainer.app.log
import com.mawistudios.trainer.trainer.data.observer.TrainingSessionObservable
import com.mawistudios.trainer.trainer.model.DataPointType
import com.mawistudios.trainer.trainer.model.SensorData
import com.wahoofitness.connector.capabilities.Capability
import com.wahoofitness.connector.capabilities.Heartrate
import com.wahoofitness.connector.conn.connections.SensorConnection
import java.util.*

class HearthRateSensorStrategy(

) : ICapabilityStrategy {
    override fun handleData(connection: SensorConnection) {
        log("new hearth rate capability")
        val hearthRate =
                connection.getCurrentCapability(Capability.CapabilityType.Heartrate) as Heartrate

        hearthRate.addListener(object : Heartrate.Listener {
            override fun onHeartrateData(data: Heartrate.Data) {
                log(data.toString())
                val sensorData = SensorData(
                        dataPoint = data.heartrate.asEventsPerMinute(),
                        time = Date(data.timeMs),
                        dataPointType = DataPointType.HEARTHRATE_BPM
                )
                TrainingSessionObservable.onNewSensorData(sensorData)
            }

            override fun onHeartrateDataReset() {}
        })
    }
}
