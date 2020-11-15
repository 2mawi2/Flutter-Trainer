import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

FlatButton flatDefault(String text, VoidCallback callback) {
  return FlatButton(
    color: Colors.grey.withAlpha(70),
    onPressed: callback,
    child: Text(text, style: TextStyle(fontSize: 20.0)),
    splashColor: Colors.blueAccent,
    disabledColor: Colors.grey,
    disabledTextColor: Colors.black,
  );
}
