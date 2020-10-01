import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:receipt_parser/widgets/home.dart';
import 'package:receipt_parser/widgets/home_old.dart';
import 'package:receipt_parser/widgets/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPrefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  FlutterStatusbarcolor.setStatusBarColor(Colors.white);
  runApp(MaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final List<Widget> _children = [
    HomeWidget(sharedPrefs),
    PlaceholderWidget(Colors.blueAccent),
    PlaceholderWidget(Colors.blueAccent),
    SettingsWidget(sharedPrefs)
  ];

  int _curent_index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Scan receipt')),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.blueAccent,
          color: Colors.white,
          items: <Widget>[
            Icon(Icons.home, size: 30, color: Colors.black),
            Icon(Icons.history, size: 30, color: Colors.black),
            Icon(Icons.pie_chart, size: 30, color: Colors.black),
            Icon(Icons.settings, size: 30, color: Colors.black),
          ],
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              this._curent_index = index;
            });
          },
        ),
        body: _children[_curent_index]);
  }
}
