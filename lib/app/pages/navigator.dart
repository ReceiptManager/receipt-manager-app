/*
 * Copyright (c) 2020 - 2021 : William Todt
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:receipt_manager/app/pages/history/history_view.dart';
import 'package:receipt_manager/app/pages/home/home_view.dart';
import 'package:receipt_manager/app/pages/settings/settings_view.dart';
import 'package:receipt_manager/app/pages/stats/stat_view.dart';

class NavigatorPage extends View {
  @override
  NavigatorState createState() => NavigatorState();
}

class NavigatorState extends State {
  int currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    HistoryPage(),
    StatsPage(),
    SettingsPage()
  ];

  Widget navigatorWidget(icon) => Icon(icon, color: Colors.black, size: 30);

  @override
  Widget build(BuildContext context) {
    readSettings();

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              showSelectedLabels: false,
              items: [
                BottomNavigationBarItem(
                    label: "", icon: navigatorWidget(Icons.add)),
                BottomNavigationBarItem(
                    label: "", icon: navigatorWidget(Icons.history)),
                BottomNavigationBarItem(
                    label: "", icon: navigatorWidget(Icons.analytics_outlined)),
                BottomNavigationBarItem(
                    label: "", icon: navigatorWidget(Icons.settings)),
              ],
              selectedItemColor: Colors.black,
              onTap: (int i) {
                setState(() {
                  currentIndex = i;
                });
              },
            ),
            body: _children[currentIndex]));
  }

  Future<void> readSettings() async {
    await Hive.openBox('settings');
  }
}
