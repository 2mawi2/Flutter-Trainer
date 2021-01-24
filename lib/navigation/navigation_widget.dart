import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainer/data/local/preferences_repo.dart';
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
  List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    Text(
      'Training History',
      style: optionStyle,
    ),
    //Text(
    //  'Training History 2',
    //  style: optionStyle,
    //),
    ZoneWidget(preferencesRepo: PreferencesRepo()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trainer'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
