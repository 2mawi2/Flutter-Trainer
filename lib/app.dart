import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigation/navigation_widget.dart';

class TrainerApp extends StatelessWidget {
  static buildMaterialApp(Widget widget) {
    return MaterialApp(
      title: 'Trainer',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(NavigationWidget());
  }
}
