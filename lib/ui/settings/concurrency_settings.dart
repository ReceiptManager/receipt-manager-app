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
import 'package:receipt_manager/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ConcurrencySetting extends StatefulWidget {
  SharedPreferences sharedPreferences;

  ConcurrencySetting(this.sharedPreferences);

  @override
  _ConcurrencySettingState createState() =>
      _ConcurrencySettingState(this.sharedPreferences);
}

class _ConcurrencySettingState extends State<ConcurrencySetting> {
  SharedPreferences sharedPreferences;

  _ConcurrencySettingState(this.sharedPreferences);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(S.of(context).language)), body: Container());
  }
}
