/*
 *  Copyright (c) 2020 - William Todt
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:provider/provider.dart';
import 'package:receipt_manager/bloc/moor/bloc.dart';
import 'package:receipt_manager/database/receipt_database.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/repository/repository.dart';
import 'package:receipt_manager/theme/color/color.dart';
import 'package:receipt_manager/theme/theme_manager.dart';
import 'package:receipt_manager/ui/history/history_widget.dart';
import 'package:receipt_manager/ui/home/home_widget.dart';
import 'package:receipt_manager/ui/settings/settings_widget.dart';
import 'package:receipt_manager/ui/stats/stats_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Repository _repository = Repository();
SharedPreferences sharedPrefs;
DbBloc _bloc;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  _bloc = DbBloc(repository: _repository);
  _bloc.add(ReceiptAllFetch());

  if (!sharedPrefs.containsKey("skip")) {
    sharedPrefs.setBool("skip", false);
  }

  runApp(MaterialApp(
      color: LightColor.brighter,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: OnboardScreen(sharedPrefs),
      theme: AppTheme.lightTheme.copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      )));
}

class HomeScreen extends StatefulWidget {
  final ReceiptsCompanion receipt;
  final bool sendImage;

  HomeScreen(this.receipt, this.sendImage);

  @override
  HomeScreenState createState() => HomeScreenState(receipt, sendImage);
}

class OnboardScreen extends StatefulWidget {
  final SharedPreferences sharedPrefs;

  OnboardScreen(this.sharedPrefs);

  @override
  OnboardScreenState createState() => OnboardScreenState(sharedPrefs);
}

class OnboardScreenState extends State<OnboardScreen> {
  final PageController _pageController = PageController();
  final SharedPreferences sharedPrefs;

  var skipOnboardMethod = false;

  OnboardScreenState(this.sharedPrefs);

  @override
  Widget build(BuildContext context) {
    if (sharedPrefs.getBool("skip") == true) return HomeScreen(null, false);

    final List<OnBoardModel> onBoardData = [
      OnBoardModel(
        title: S.of(context).ocrTitle,
        description: S.of(context).ocrDescription,
        imgUrl: "assets/data.png",
      ),
      OnBoardModel(
        title: S.of(context).statsTitle,
        description: S.of(context).startsDescription,
        imgUrl: "assets/charts.png",
      ),
    ];

    return Provider<OnBoardState>(
      create: (_) => OnBoardState(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: OnBoard(
          pageController: _pageController,
          onSkip: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(null, false)));
          },
          onDone: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(null, false)));
          },
          onBoardData: onBoardData,
          titleStyles: TextStyle(
            color: LightColor.brighter,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.15,
          ),
          descriptionStyles: TextStyle(
            fontSize: 16,
            color: LightColor.grey,
          ),
          pageIndicatorStyle: PageIndicatorStyle(
            width: 100,
            inactiveSize: Size(8, 8),
            activeSize: Size(12, 12),
          ),
          skipButton: FlatButton(
            onPressed: () {
              sharedPrefs.setBool("skip", true);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(null, false)));
            },
            child: Text(
              S.of(context).skip,
              style: TextStyle(color: LightColor.brighter),
            ),
          ),
          nextButton: Consumer<OnBoardState>(
            builder: (BuildContext context, OnBoardState state, Widget child) {
              return InkWell(
                onTap: () => _onNextTap(state),
                child: Container(
                  width: 230,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [LightColor.brighter, LightColor.brighter],
                    ),
                  ),
                  child: Text(
                    state.isLastPage ? S.of(context).done : S.of(context).next,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      sharedPrefs.setBool("skip", true);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(null, false)));
    }
  }
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey _bottomNavigationKey = GlobalKey();

  // current receipt
  final ReceiptsCompanion receipt;
  bool sendImage;

  // set current body index
  int currentIndex = 0;

  HomeScreenState(this.receipt, this.sendImage);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      HomeWidget(this.receipt, sendImage, sharedPrefs, _bloc),
      HistoryWidget(_bloc),
      StatsWidget(_bloc),
      SettingsWidget(sharedPrefs)
    ];

    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(S.of(context).appBarTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,

              )),
              automaticallyImplyLeading: false,
              shadowColor: LightColor.black,
              centerTitle: true,
            ),
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
                  this.sendImage = false;
                });
              },
            ),
            body: _children[currentIndex]));
  }
}
