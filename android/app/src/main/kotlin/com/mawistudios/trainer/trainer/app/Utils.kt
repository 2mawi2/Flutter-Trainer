package com.mawistudios.trainer.trainer.app

import android.app.Activity
import android.content.Context
import android.widget.Toast
import com.mawistudios.trainer.trainer.model.Sensor
import com.wahoofitness.connector.HardwareConnectorEnums
import java.net.URI
import kotlin.math.abs


fun areClose(first: Double, second: Double, precision: Double): Boolean {
    val distance = abs(first - second)
    return distance <= precision
}


object GlobalState {
    var isKoinInitialized = false
    var isObjectBoxInitialized = false
    var isLocationPermissionRequested = false
}

fun appendQueryParam(uri: String, queryParam: String): URI {
    val oldUri = URI(uri)

    var newQuery = oldUri.query

    if (newQuery == null) {
        newQuery = queryParam
    } else {
        newQuery += "&$queryParam"
    }

    return URI(
            oldUri.scheme, oldUri.authority,
            oldUri.path, newQuery, oldUri.fragment
    )
}

fun Double.format(digits: Int) = "%.${digits}f".format(this)

fun Activity.toast(message: String) {
    Toast.makeText(this, message, Toast.LENGTH_LONG).show()
}


inline fun <T> Iterable<T>.sumByLong(selector: (T) -> Long): Long {
    var sum = 0L
    for (element in this) {
        sum += selector(element)
    }
    return sum
}

fun Sensor.resetState(): Sensor {
    state = HardwareConnectorEnums.SensorConnectionState.DISCONNECTED.name
    return this
}

fun secondsToMillis(seconds: Long) = seconds * 1000L
fun minutesToMillis(minutes: Long) = secondsToMillis(minutes * 60L)
fun hoursToMillis(hours: Long) = minutesToMillis(hours * 60L)

fun secondsToMillis(seconds: Int): Long = seconds * 1000L
fun minutesToMillis(minutes: Int): Long = secondsToMillis(minutes * 60)
fun hoursToMillis(hours: Int): Long = minutesToMillis(hours * 60)