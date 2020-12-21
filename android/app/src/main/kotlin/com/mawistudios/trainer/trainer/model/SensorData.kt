package com.mawistudios.trainer.trainer.model

import java.util.*

data class SensorData(
        var time: Date,
        var dataPointType: DataPointType,
        var dataPoint: Double
)