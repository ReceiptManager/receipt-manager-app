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
import 'package:receipt_manager/theme/color/color.dart';
import 'package:settings_ui/settings_ui.dart';

class LanguageSetting extends StatefulWidget {
  @override
  _LanguageSettingState createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
  String currentLanguage = Intl.getCurrentLocale();
  int languageIndex = 0;

  List<Locale> locales = S.delegate.supportedLocales;
  List<Locale> sortedLocals;

  @override
  void initState() {
    log(Intl.getCurrentLocale());
    sortedLocals = List.from(locales);
    sortedLocals
        .sort((Locale a, Locale b) => a.toString().compareTo(b.toString()));

    languageIndex = sortedLocals
        .indexWhere((element) => element.toString() == currentLanguage);

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
            /*
            SettingsTile(
              title: "English (GB)",
              leading: trailingWidget(1),
              onTap: () {
                changeLanguage(1);
                S.load(sortedLocals[1]);
              },
            )
             */
            SettingsTile(
              title: "English (US)",
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
    setState(() {
      languageIndex = pos;
    });
  }
}
