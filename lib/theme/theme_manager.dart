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

import 'package:flutter/material.dart';
import 'package:receipt_manager/theme/color/color.dart';

class AppTheme {
  const AppTheme();

  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.red,
    backgroundColor: Colors.grey[200],
    primaryColor: LightColor.black,
    accentColor: Colors.red,
    primaryColorDark: LightColor.black,
    primaryColorLight: LightColor.black,
    fontFamily: "Encode Sans",
    canvasColor: Colors.grey[200],
    cardTheme: CardTheme(color: Colors.grey[200]),
    // ignore: deprecated_member_use
    textTheme: TextTheme(display1: TextStyle(color: LightColor.black)),
    iconTheme: IconThemeData(color: LightColor.darkBlue),
    bottomAppBarColor: LightColor.background,
    dividerColor: LightColor.lightGrey,
    colorScheme: ColorScheme(
        primary: LightColor.black,
        primaryVariant: LightColor.black,
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
