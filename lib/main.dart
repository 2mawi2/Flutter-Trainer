import 'package:flutter/material.dart';
import 'package:trainer/home/HomeWidget.dart';
import 'package:trainer/zone/ZoneWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeWidget(),
    );
  }
}
