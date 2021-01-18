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

import 'package:flutter/material.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/ui/settings/api_settings.dart';
import 'package:receipt_manager/ui/settings/open_source.dart';
import 'package:receipt_manager/ui/settings/server_settings.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language_setting.dart';

class SettingsWidget extends StatefulWidget {
  final SharedPreferences _prefs;

  SettingsWidget(this._prefs);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState(_prefs);
}

class _SettingsWidgetState extends State<SettingsWidget> {
  bool _grayscale = false;
  bool _gaussian = false;
  bool _debugOutput = false;
  bool _legacyParser = true;
  bool _rotate = false;
  bool _sendTrainingData = false;
  
  final SharedPreferences _prefs;

  _SettingsWidgetState(this._prefs);

  readFallbackValues() {
    _debugOutput = _prefs.getBool("enable_debug_output") == null
        ? _debugOutput
        : _prefs.getBool("enable_debug_output");
    _legacyParser = _prefs.getBool("legacyParser") == null
        ? _legacyParser
        : _prefs.getBool("legacyParser");
    _grayscale = _prefs.getBool("grayscale") == null
        ? _grayscale
        : _prefs.getBool("grayscale");
    _gaussian = _prefs.getBool("gaussian") == null
        ? _gaussian
        : _prefs.getBool("gaussian");
    _rotate =
        _prefs.getBool("rotate") == null ? _rotate : _prefs.getBool("rotate");

    _sendTrainingData =
    _prefs.getBool("sendTrainingData") == null ? _sendTrainingData : _prefs.getBool("sendTrainingData");
  }

  @override
  Widget build(BuildContext context) {
    readFallbackValues();

    return
      SettingsList(
        shrinkWrap: true,
        backgroundColor: Colors.white,
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
                      builder: (BuildContext context) =>
                          LanguageSetting(_prefs)));
                },
              ),
              SettingsTile(
                title: S.of(context).settingsServerTitle,
                leading: Icon(Icons.wifi),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ServerSettings(_prefs)));
                },
              ),
              SettingsTile(
                title: S.of(context).apitoken,
                leading: Icon(Icons.vpn_key),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ApiSettings(_prefs)));
                },
              ),
            ],
          ),
          SettingsSection(
            title: S.of(context).cameraSettings,
            tiles: [
              SettingsTile.switchTile(
                title: S.of(context).rotateImage,
                leading: Icon(Icons.rotate_right_sharp),
                switchValue: _rotate,
                onToggle: (bool value) {
                  setState(() {
                    _rotate = value;
                    _prefs.setBool("rotate", value);
                  });
                },
              ),
              SettingsTile.switchTile(
                title: S.of(context).grayscaleImage,
                leading: Icon(Icons.wb_incandescent_outlined),
                switchValue: _grayscale,
                onToggle: (bool value) {
                  setState(() {
                    _grayscale = value;
                    _prefs.setBool("grayscale", value);
                  });
                },
              ),
              SettingsTile.switchTile(
                title: S.of(context).gaussianBlur,
                leading: Icon(Icons.blur_on_outlined),
                switchValue: _gaussian,
                onToggle: (bool value) {
                  setState(() {
                    _gaussian = value;
                    _prefs.setBool("gaussian", value);
                  });
                },
              ),
              SettingsTile.switchTile(
                title: S.of(context).neuronalNetworkParser,
                leading: Icon(Icons.camera_enhance_outlined),
                switchValue: !_legacyParser,
                onToggle: (bool value) {
                  setState(() {
                    _legacyParser = !value;
                    _prefs.setBool("legacyParser", !value);
                  });
                },
              ),
              SettingsTile.switchTile(
                title: S.of(context).fuzzyParser,
                leading: Icon(Icons.camera_enhance_rounded),
                switchValue: _legacyParser,
                onToggle: (bool value) {
                  setState(() {
                    _legacyParser = value;
                    _prefs.setBool("legacyParser", value);
                  });
                },
              ),
              SettingsTile.switchTile(
                title: S.of(context).sendTrainingData,
                leading: Icon(Icons.model_training),
                switchValue: _sendTrainingData,
                onToggle: (bool value) {
                  setState(() {
                    _sendTrainingData = value;
                    _prefs.setBool("sendTrainingData", value);
                  });
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
                switchValue: _debugOutput,
                onToggle: (bool value) {
                  setState(() {
                    _debugOutput = value;
                    _prefs.setBool("enable_debug_output", value);
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            title: S.of(context).licence,
            tiles: [
              SettingsTile(
                title: S.of(context).opensourceLicences,
                leading: Icon(Icons.wysiwyg),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          OpenSourceSettings()));
                },
              ),
            ],
          )
        ],
      );
  }
}
