import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainer/common/data/local/preferences_repo.dart';
import 'package:trainer/home/home_widget.dart';
import 'package:trainer/zone/zone_widget.dart';

class NavigationWidget extends StatefulWidget {
  NavigationWidget({Key key}) : super(key: key);

  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> pages = <Widget>[
    HomeWidget(
      key: PageStorageKey("Home"),
    ),
    Text(
      'Training History',
      style: optionStyle,
      key: PageStorageKey("History"),
    ),
    ZoneWidget(
        key: PageStorageKey("Zones"),
        preferencesRepo: PreferencesRepo()
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final PageStorageBucket pageStorageBucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trainer'),
      ),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: pageStorageBucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text("History"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
