/*
 * Copyright (c) 2020 - William Todt
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
import 'package:receipt_manager/bloc/moor/bloc.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/ui/settings/server_settings.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings/language_setting.dart';

class SettingsWidget extends StatefulWidget {
  final SharedPreferences sharedPreferences;
  final DbBloc _bloc;

  SettingsWidget(this.sharedPreferences, this._bloc);

  @override
  _SettingsWidgetState createState() =>
      _SettingsWidgetState(sharedPreferences, _bloc);
}

class _SettingsWidgetState extends State<SettingsWidget> {
  bool enableDebugOutput = true;
  bool notificationsEnabled = true;

  final DbBloc _bloc;
  final SharedPreferences sharedPreferences;

  _SettingsWidgetState(this.sharedPreferences, this._bloc);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SettingsList(
        sections: [
          SettingsSection(
            title: S.of(context).settingsGeneralCategory,
            tiles: [
              SettingsTile(
                title: S.of(context).settingsLanguageTitle,
                subtitle: S.of(context).currentLanguage,
                leading: Icon(Icons.language),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LanguageSetting()));
                },
              ),
              SettingsTile(
                title: S.of(context).settingsServerTitle,
                leading: Icon(Icons.wifi),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ServerSettings(sharedPreferences)));
                },
              ),
            ],
          ),
          SettingsSection(
            title: S.of(context).settingsDevelopmentTitle,
            tiles: [
              SettingsTile.switchTile(
                title: S.of(context).enableDebugOutput,
                leading: Icon(Icons.bug_report),
                switchValue: enableDebugOutput,
                onToggle: (bool value) {
                  setState(() {
                    enableDebugOutput = value;
                    notificationsEnabled = value;
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            title: S.of(context).settingsMiscTitle,
            tiles: [
              SettingsTile(
                  title: S.of(context).openSourceLicence,
                  leading: Icon(Icons.collections_bookmark)),
            ],
          )
        ],
      ),
    );
  }
}
