import 'package:flutter/material.dart';

class ThemeManager {
  static ThemeData getTheme() {
    Map<int, Color> colorCodes = {
      50: Color.fromRGBO(147, 205, 72, .1),
      100: Color.fromRGBO(147, 205, 72, .2),
      200: Color.fromRGBO(147, 205, 72, .3),
      300: Color.fromRGBO(147, 205, 72, .4),
      400: Color.fromRGBO(147, 205, 72, .5),
      500: Color.fromRGBO(147, 205, 72, .6),
      600: Color.fromRGBO(147, 205, 72, .7),
      700: Color.fromRGBO(147, 205, 72, .8),
      800: Color.fromRGBO(147, 205, 72, .9),
      900: Color.fromRGBO(147, 205, 72, 1),
    };

    MaterialColor accentYellow = MaterialColor(0xF9AA33, colorCodes);

    return new ThemeData(
      primaryColor: Colors.black,
      primaryColorDark: Colors.black,
      primarySwatch: Colors.yellow,
    );
  }
}
