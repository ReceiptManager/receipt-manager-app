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
import 'package:intl/intl.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/localisation/easy_language_loader.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LanguageSetting extends StatefulWidget {
  SharedPreferences sharedPreferences;

  LanguageSetting(this.sharedPreferences);

  @override
  _LanguageSettingState createState() =>
      _LanguageSettingState(this.sharedPreferences);
}

class _LanguageSettingState extends State<LanguageSetting> {
  String currentLanguage = Intl.getCurrentLocale();
  SharedPreferences sharedPreferences;
  EasyLanguageLoader _loader;
  int languageIndex = 0;

  List<Locale> sortedLocals;

  _LanguageSettingState(this.sharedPreferences);

  @override
  void initState() {
    _loader = EasyLanguageLoader(sharedPreferences);
    sortedLocals = _loader.getLanguageArray();

    String storedLanguage = sharedPreferences.getString("language");
    if (storedLanguage == null) {
      languageIndex = _loader.findLanguageIndex(currentLanguage);
    } else {
      languageIndex = _loader.findLanguageIndex(storedLanguage);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).language)),
      body: SettingsList(
        sections: [
          SettingsSection(tiles: [
            SettingsTile(
              title: "German ",
              leading: trailingWidget(0),
              onTap: () {
                changeLanguage(0);
                S.load(sortedLocals[0]);
              },
            ),
            SettingsTile(
              title: "English",
              leading: trailingWidget(2),
              onTap: () {
                changeLanguage(2);
                S.load(sortedLocals[2]);
              },
            ),
          ]),
        ],
      ),
    );
  }

  Widget trailingWidget(int index) {
    return (languageIndex == index)
        ? Icon(Icons.check, color: Colors.red)
        : Icon(null);
  }

  void changeLanguage(int pos) {
    sharedPreferences.setString("language", sortedLocals[pos].toString());

    setState(() {
      languageIndex = pos;
    });
  }
}
