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
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:provider/provider.dart';
import 'package:receipt_manager/db/bloc/moor/bloc.dart';
import 'package:receipt_manager/db/memento/receipt_memento.dart';
import 'package:receipt_manager/db/receipt_database.dart';
import 'package:receipt_manager/db/repository/repository.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/localisation/easy_language_loader.dart';
import 'package:receipt_manager/ui/history/history_widget.dart';
import 'package:receipt_manager/ui/home/add_widget.dart';
import 'package:receipt_manager/ui/settings/settings_widget.dart';
import 'package:receipt_manager/ui/stats/stats_widget.dart';
import 'package:receipt_manager/ui/theme/color/color.dart';
import 'package:receipt_manager/ui/theme/theme_manager.dart';
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

  if (sharedPrefs.getString(SharedPreferenceKeyHolder.currency) == null) {
    sharedPrefs.setString(SharedPreferenceKeyHolder.currency, "\$");
  }

  ReceiptMemento receiptMemento = ReceiptMemento();
  receiptMemento.currency =
      sharedPrefs.getString(SharedPreferenceKeyHolder.currency);

  runApp(MaterialApp(
      color: LightColor.black,
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
    if (sharedPrefs.get(SharedPreferenceKeyHolder.showOnboardScreen) == true)
      return HomeScreen(null, false);

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
          body: Center(
            child: OnBoard(
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
                color: LightColor.black,
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
              skipButton: TextButton(
                onPressed: () {
                  setDefaultValues(sharedPrefs);
                  sharedPrefs.setBool(
                      SharedPreferenceKeyHolder.showOnboardScreen, true);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(null, false)));
                },
                child: Text(
                  S.of(context).skip,
                  style: TextStyle(color: LightColor.black),
                ),
              ),
              nextButton: Consumer<OnBoardState>(
                builder:
                    (BuildContext context, OnBoardState state, Widget child) {
                  return InkWell(
                    onTap: () => _onNextTap(state),
                    child: Container(
                      width: 230,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [LightColor.black, LightColor.black],
                        ),
                      ),
                      child: Text(
                        state.isLastPage
                            ? S.of(context).done
                            : S.of(context).next,
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
        ));
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      setDefaultValues(sharedPrefs);
      sharedPrefs.setBool(SharedPreferenceKeyHolder.showOnboardScreen, true);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(null, false)));
    }
  }

  void setDefaultValues(SharedPreferences _prefs) {
    _prefs.setBool(SharedPreferenceKeyHolder.enableDebug, false);
    _prefs.setBool(SharedPreferenceKeyHolder.legacyParser, true);
    _prefs.setBool(SharedPreferenceKeyHolder.gaussianBlur, false);
    _prefs.setBool(SharedPreferenceKeyHolder.rotate, false);
    _prefs.setBool(SharedPreferenceKeyHolder.reverseProxy, false);
    _prefs.setBool(SharedPreferenceKeyHolder.https, true);
    _prefs.setBool(SharedPreferenceKeyHolder.grayscale, true);
    _prefs.setBool(SharedPreferenceKeyHolder.sendTrainingData, false);
    _prefs.setBool(SharedPreferenceKeyHolder.showItemList, false);
    _prefs.setBool(SharedPreferenceKeyHolder.detectEdges, false);
    _prefs.setBool(SharedPreferenceKeyHolder.showParsedResults, false);
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
    EasyLanguageLoader _loader = EasyLanguageLoader(sharedPrefs);
    _loader.loadCurrentLanguage();

    final List<Widget> _children = [
      //DashboardWidget(),
      HomeWidget(this.receipt, sendImage, sharedPrefs, _bloc),
      HistoryWidget(_bloc),
      StatsWidget(_bloc),
      SettingsWidget(sharedPrefs)
    ];

    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: 0,
              items: <Widget>[
                //Icon(Icons.home_outlined, color: Colors.white, size: 30),
                Icon(Icons.add, color: Colors.white, size: 30),
                Icon(Icons.history, color: Colors.white, size: 30),
                Icon(Icons.analytics_outlined, color: Colors.white, size: 30),
                Icon(Icons.settings, color: Colors.white, size: 30),
              ],
              color: LightColor.black,
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
