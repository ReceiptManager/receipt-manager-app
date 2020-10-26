/*
 * Copyright (c) 2020 - William Todt
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:receipt_manager/bloc/moor/bloc.dart';
import 'package:receipt_manager/database/receipt_database.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/repository/repository.dart';
import 'package:receipt_manager/theme/color/color.dart';
import 'package:receipt_manager/theme/theme_manager.dart';
import 'package:receipt_manager/ui/history_widget.dart';
import 'package:receipt_manager/ui/home_widget.dart';
import 'package:receipt_manager/ui/settings_widget.dart';
import 'package:receipt_manager/ui/stats_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Repository _repository = Repository();
SharedPreferences sharedPrefs;
DbBloc _bloc;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  _bloc = DbBloc(repository: _repository);
  _bloc.add(ReceiptAllFetch());

  runApp(MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: HomeScreen(null, false),
      theme: AppTheme.lightTheme));
}

class HomeScreen extends StatefulWidget {
  final ReceiptsCompanion receipt;
  final bool sendImage;

  HomeScreen(this.receipt, this.sendImage);

  @override
  HomeScreenState createState() => HomeScreenState(receipt, sendImage);
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey _bottomNavigationKey = GlobalKey();

  // current receipt
  final ReceiptsCompanion receipt;
  final bool sendImage;

  // set current body index
  int currentIndex = 0;

  HomeScreenState(this.receipt, this.sendImage);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      HomeWidget(this.receipt, sendImage, sharedPrefs, _bloc),
      HistoryWidget(_bloc),
      StatsWidget(_bloc),
      SettingsWidget(sharedPrefs, _bloc)
    ];

    return Scaffold(
        appBar: AppBar(title: Text(S.of(context).appBarTitle)),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.add, color: Colors.white, size: 30),
            Icon(Icons.history, color: Colors.white, size: 30),
            Icon(Icons.analytics_outlined, color: Colors.white, size: 30),
            Icon(Icons.settings, color: Colors.white, size: 30),
          ],
          color: LightColor.brighter,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        body: _children[currentIndex]);
  }
}
