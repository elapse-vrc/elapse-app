import 'package:elapse/elapse_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elapse/pages/matches.dart';
import 'package:elapse/pages/home.dart';
import 'package:elapse/pages/settings.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        home: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    GameList(),
    HomePage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(

        showSelectedLabels: true,
        showUnselectedLabels: false,
        //temporary icons used below

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(ElapseIcons.matches),
            title: Text('•'),
          ),
          BottomNavigationBarItem(
            icon: Icon(ElapseIcons.home),
            title: Text('•'),
          ),
          BottomNavigationBarItem(
            icon: Icon(ElapseIcons.settings),
            title: Text('•'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey[850],
        onTap: _onItemTapped,
        backgroundColor: const Color.fromARGB(255, 250, 255, 254),
        elevation: 20,
      ),
    );
  }
}
