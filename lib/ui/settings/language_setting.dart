/*
 * Copyright (c) 2020 William Todt
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:receipt_parser/generated/l10n.dart';
import 'package:settings_ui/settings_ui.dart';

class LanguageSetting extends StatefulWidget {
  @override
  _LanguageSettingState createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
  int languageIndex = 0;

  @override
  void initState() {
    getLanguagePosition();
  }

  getLanguagePosition() {
    int pos = 0;
    for (Locale l in S.delegate.supportedLocales) {
      if (l.toString() == Intl.getCurrentLocale()) {
        languageIndex = pos;
        return;
      }
      pos++;
    }
  }

  SettingsList generateLanguageList() {
    return SettingsList(
      sections: [
        SettingsSection(tiles: [
          SettingsTile(
            title: "English (US)",
            leading: trailingWidget(0),
            onTap: () {
              S.load((Locale('en', 'US')));
              changeLanguage(0);
            },
          ),
          SettingsTile(
            title: "English (GB)",
            leading: trailingWidget(1),
            onTap: () {
              S.load((Locale('en', 'GB')));
              changeLanguage(1);
            },
          ),
          SettingsTile(
            title: "German",
            leading: trailingWidget(2),
            onTap: () {
              S.load((Locale('de', 'DE')));
              changeLanguage(2);
            },
          ),
        ]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Languages')), body: generateLanguageList());
  }

  Widget trailingWidget(int index) {
    return (languageIndex == index)
        ? Icon(Icons.check, color: Colors.black)
        : Icon(null);
  }

  void changeLanguage(int index) {
    setState(() {
      languageIndex = index;
    });
  }
}
