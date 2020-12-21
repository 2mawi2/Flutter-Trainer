package com.mawistudios.trainer.trainer.model

import com.google.gson.annotations.SerializedName

enum class DataPointType {
    @SerializedName("HEARTHRATE_BPM")
    HEARTHRATE_BPM,

    @SerializedName("WHEELREVS_KMH")
    WHEELREVS_KMH,

    @SerializedName("WHEELREVS_DISTANCE")
    WHEELREVS_DISTANCE,

    @SerializedName("CRANKREVS_CADENCE")
    CRANKREVS_CADENCE,

    @SerializedName("POWER_WATT")
    POWER_WATT
}