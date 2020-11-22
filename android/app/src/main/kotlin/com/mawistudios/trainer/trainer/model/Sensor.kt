package com.mawistudios.trainer.trainer.model

import com.wahoofitness.connector.conn.connections.params.ConnectionParams

data class Sensor(
        var id: Long = 0,
        var state: String? = null,
        var name: String = "",
        var params: String? = null
) {
    fun setParameters(connectionParams: ConnectionParams) {
        params = connectionParams.serialize()
    }

    fun getParameters(): ConnectionParams? {
        if (params == null) return null
        return ConnectionParams.deserialize(
                params
        )
    }

    fun isConnected(): Boolean = this.state.equals("connected", true)
}