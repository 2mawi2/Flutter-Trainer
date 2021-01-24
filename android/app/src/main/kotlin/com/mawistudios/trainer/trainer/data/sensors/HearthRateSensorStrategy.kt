package com.mawistudios.trainer.trainer.data.sensors

import com.mawistudios.trainer.trainer.app.log
import com.mawistudios.trainer.trainer.data.observer.TrainingSessionObservable
import com.mawistudios.trainer.trainer.model.DataPointType
import com.mawistudios.trainer.trainer.model.SensorData
import com.wahoofitness.connector.capabilities.Capability
import com.wahoofitness.connector.capabilities.CrankRevs
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
                        sensorId = connection.id,
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

class CrankRevsSensorStrategy() : ICapabilityStrategy {

    override fun handleData(connection: SensorConnection) {
        log("new crank revs capability")
        val revs = connection.getCurrentCapability(Capability.CapabilityType.CrankRevs) as CrankRevs

        revs.addListener { data ->
            log(data.toString())
            val sensorData = SensorData(
                    sensorId = connection.id,
                    dataPoint = data.crankRevs.toDouble(),
                    time = Date(data.timeMs),
                    dataPointType = DataPointType.CRANKREVS_CADENCE
            )
            TrainingSessionObservable.onNewSensorData(sensorData)
        }
    }
}



