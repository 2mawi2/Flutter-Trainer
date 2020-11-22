import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainer/data/local/preferences_repo.dart';
import 'package:trainer/zone/zone_helper.dart';

class ZoneWidget extends StatefulWidget {
  final PreferencesRepo preferencesRepo;

  ZoneWidget({Key key, this.preferencesRepo}) : super(key: key);

  @override
  _ZoneState createState() => _ZoneState(preferencesRepo: preferencesRepo);
}

class _ZoneState extends State<ZoneWidget> {
  final PreferencesRepo preferencesRepo;

  _ZoneState({this.preferencesRepo}) {}

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
              key: Key("inp_ftp"),
              controller: ftpTextEditingController,
              validator: (value) {
                return isValidFtp(value) ? "Please enter a valid FTP" : null;
              },
            ),
          ),
          Spacer(),
          FlatButton(
            key: Key("btn_calculate"),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                var ftp = int.parse(ftpTextEditingController.text);
                preferencesRepo.setFtp(ftp);
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

  StatefulWidget zones() {
    return FutureBuilder<int>(
      future: preferencesRepo.getFtp(),
      builder: (context, ftpSnapshot) {
        return Column(
          children: ftpSnapshot.hasData ? generateZoneTable(ftpSnapshot.data) : [],
        );
      },
    );
  }

  List<Padding> generateZoneTable(int ftp) {
    ftpTextEditingController.text = ftp.toString();
    return getZones(ftp)
        .map((zone) => Padding(
              padding: EdgeInsets.only(top: 20.0, left: 60.0, right: 60.0),
              child: Table(
                columnWidths: {1: FractionColumnWidth(.4)},
                children: [
                  TableRow(children: [
                    Text(zone.name, style: TextStyle(fontSize: 17.0)),
                    Text(zone.getFormattedZones(),
                        key: Key("txt_zone_value"), style: TextStyle(fontSize: 17.0)),
                  ])
                ],
              ),
            ))
        .toList();
  }
}
