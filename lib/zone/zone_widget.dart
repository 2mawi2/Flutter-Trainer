import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainer/zone/zone_helper.dart';


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

  final _formKey = GlobalKey<FormState>();
  final ftpTextEditingController = TextEditingController();

  var _userFtp = 200;

  ftpForm() {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text("FTP", style: TextStyle(fontSize: 20.0)),
          Spacer(),
          Container(
            width: 50,
            child: TextFormField(
              controller: ftpTextEditingController,
              validator: (value) {
                return isValidFtp(value) ? "Please enter a valid FTP" : null;
              },
            ),
          ),
          Spacer(),
          FlatButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _userFtp = int.parse(ftpTextEditingController.text);
                setState(() {});
              }
            },
            color: Colors.grey.withAlpha(80),
            child: Text('Calculate Zones'),
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    ftpTextEditingController.dispose();
    super.dispose();
  }

  bool isValidFtp(String value) {
    var ftp = int.tryParse(value) ?? -1;
    return ftp < 0;
  }

  Column zones() {
    return Column(
      children: getZones(_userFtp)
          .map((zone) =>
          Padding(
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
