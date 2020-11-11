import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainer/zone/Zone.dart';
import 'package:trainer/zone/ZoneHelper.dart';

import '../common/Styles.dart';

class ZoneWidget extends StatefulWidget {
  ZoneWidget({Key key}) : super(key: key);

  @override
  _ZoneState createState() => _ZoneState();
}

class _ZoneState extends State<ZoneWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zones"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            ftpForm(),
            Spacer(),
            zones(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  ftpForm() {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text("FTP", style: TextStyle(fontSize: 20.0)),
          Spacer(),
          Container(
            width: 50,
            child: TextFormField(),
          ),
          Spacer(),
          FlatButton(
            onPressed: () {},
            color: Colors.grey.withAlpha(80),
            child: Text('Calculate Zones'),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Column zones() {
    return Column(
      children: getZones(200)
          .map((zone) => Padding(
                padding: EdgeInsets.only(top: 20.0, left: 60.0, right: 60.0),
                child: Table(
                  columnWidths: {1: FractionColumnWidth(.4)},
                  children: [
                    TableRow(children: [
                      Text(zone.name, style: TextStyle(fontSize: 17.0)),
                      Text(zone.getFormattedZones(),
                          style: TextStyle(fontSize: 17.0)),
                    ])
                  ],
                ),
              ))
          .toList(),
    );
  }
}
