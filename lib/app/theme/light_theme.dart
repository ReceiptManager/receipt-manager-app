import 'dart:ui';

import 'package:flutter/material.dart';

import 'color.dart';

class AppTheme {
  const AppTheme();

  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.red,
    backgroundColor: Colors.grey[200],
    primaryColor: LightColor.black,
    accentColor: Colors.red,
    primaryColorDark: Colors.red,
    primaryColorLight: LightColor.black,
    fontFamily: "Encode Sans",
    canvasColor: Colors.grey[200],
    cardTheme: CardTheme(color: Colors.grey[200]),
    // ignore: deprecated_member_use
    textTheme: TextTheme(display1: TextStyle(color: LightColor.black)),
    iconTheme: IconThemeData(color: Colors.red),
    bottomAppBarColor: LightColor.background,
    dividerColor: LightColor.lightGrey,
    colorScheme: ColorScheme(
        primary: Colors.red,
        primaryVariant: Colors.red,
        secondary: LightColor.black,
        secondaryVariant: LightColor.black,
        surface: LightColor.background,
        background: LightColor.background,
        error: Colors.red,
        onPrimary: LightColor.Darker,
        onSecondary: LightColor.background,
        onSurface: LightColor.Darker,
        onBackground: LightColor.titleTextColor,
        onError: LightColor.titleTextColor,
        brightness: Brightness.light),
  );

  static TextStyle titleStyle =
      const TextStyle(color: LightColor.titleTextColor, fontSize: 16);
  static TextStyle subTitleStyle =
      const TextStyle(color: LightColor.subTitleTextColor, fontSize: 12);

  static TextStyle h1Style =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);
}
