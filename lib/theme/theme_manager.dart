import 'package:flutter/material.dart';

class ThemeManager {
  static MaterialColor getYellow() {
    Map<int, Color> accentYellow = {
      50: Color.fromRGBO(249, 170, 51, .1),
      100: Color.fromRGBO(249, 170, 51, .2),
      200: Color.fromRGBO(249, 170, 51, .3),
      300: Color.fromRGBO(249, 170, 51, .4),
      400: Color.fromRGBO(249, 170, 51, .5),
      500: Color.fromRGBO(249, 170, 51, .6),
      600: Color.fromRGBO(249, 170, 51, .7),
      700: Color.fromRGBO(249, 170, 51, .8),
      800: Color.fromRGBO(249, 170, 51, .9),
      900: Color.fromRGBO(249, 170, 51, 1),
    };

    return MaterialColor(0XFFF9AA33, accentYellow);
  }

  static MaterialColor getGray() {
    Map<int, Color> accentGray = {
      50: Color.fromRGBO(35, 47, 62, .1),
      100: Color.fromRGBO(35, 47, 62, .2),
      200: Color.fromRGBO(35, 47, 62, .3),
      300: Color.fromRGBO(35, 47, 62, .4),
      400: Color.fromRGBO(35, 47, 62, .5),
      500: Color.fromRGBO(35, 47, 62, .6),
      600: Color.fromRGBO(35, 47, 62, .7),
      700: Color.fromRGBO(35, 47, 62, .8),
      800: Color.fromRGBO(35, 47, 62, .9),
      900: Color.fromRGBO(35, 47, 62, 1),
    };

    return MaterialColor(0XFF232F3E, accentGray);
  }

  static ThemeData getTheme() {
    return new ThemeData(
        primaryColor: getGray(),
        primaryColorDark: Colors.white,
        primarySwatch: getYellow(),
        accentColor: getYellow(),
        focusColor: Colors.white,
        brightness: Brightness.light,
        primaryColorBrightness: Brightness.light,
        bottomAppBarColor: Colors.white,
        typography: Typography.material2018(),
        primaryTextTheme: TextTheme(
            // ignore: deprecated_member_use
            title: TextStyle(color: Colors.white)),
        backgroundColor: Colors.white);
  }
}
