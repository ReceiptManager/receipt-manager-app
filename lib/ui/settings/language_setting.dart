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
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/localisation/easy_language_loader.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
