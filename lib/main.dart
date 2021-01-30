import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:trainer/common/data/native/SensorChannel.dart';
import 'app.dart';
import 'common/data/local/preferences_repo.dart';
import 'container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerDependencies();
  
  runApp(TrainerApp());
}

void registerDependencies() {
  getIt.registerSingleton(PreferencesRepo());
  getIt.registerSingleton(SensorChannel());
}
