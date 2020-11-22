import 'package:flutter/services.dart';

class SensorChannel {
  static const platform = const MethodChannel("com.mawistudios.trainer/sensor");

  Future<void> startService() async {
    String status = await platform.invokeMethod("startService");
    
    print("Invoked startService with result code: $status");

  }
}
