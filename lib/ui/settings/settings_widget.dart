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
import 'package:receipt_manager/ui/settings/api_settings.dart';
import 'package:receipt_manager/ui/settings/licence.dart';
import 'package:receipt_manager/ui/settings/server_settings.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'discovery_settings.dart';
import 'language_setting.dart';

class SettingsWidget extends StatefulWidget {
  final SharedPreferences _prefs;

  SettingsWidget(this._prefs);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState(_prefs);
}

class SharedPreferenceKeyHolder {
  static final enableDebug = "enable_debug_output";
  static final legacyParser = "legacyParser";
  static final grayscale = "grayscale";
  static final gaussianBlur = "gaussian";
  static final rotate = "rotate";
  static final sendTrainingData = "sendTrainingData";
  static final showItemList = "showItemList";
  static final https = "https";
  static final reverseProxy = "reverseProxy";
  static final showOnboardScreen = "showOnboardScreen";
  static final domain = "domain";
  static final apiToken = "api_token";
  static final ip = "ipv4";
  static final detectEdges = "detect_edges";
  static final showParsedResults = "parsed_results";
}

class _SettingsWidgetState extends State<SettingsWidget> {
  bool _grayscale = false;
  bool _gaussian = false;
  bool _debugOutput = false;
  bool _legacyParser = true;
  bool _rotate = false;
  bool _sendTrainingData = false;
  bool _showItemList = false;
  bool _https = true;
  bool _edgeDetection = false;
  bool _showParsedResults = false;

  final GlobalKey<ScaffoldState> _scaffoldKey4 = GlobalKey<ScaffoldState>();
  final SharedPreferences _prefs;

  _SettingsWidgetState(this._prefs);

  readFallbackValues() {
    _debugOutput = _prefs.getBool(SharedPreferenceKeyHolder.enableDebug);
    _legacyParser = _prefs.getBool(SharedPreferenceKeyHolder.legacyParser);
    _grayscale = _prefs.getBool(SharedPreferenceKeyHolder.grayscale);
    _gaussian = _prefs.getBool(SharedPreferenceKeyHolder.gaussianBlur);
    _rotate = _prefs.getBool(SharedPreferenceKeyHolder.rotate);
    _sendTrainingData = _prefs.getBool(SharedPreferenceKeyHolder.sendTrainingData);
    _showItemList = _prefs.getBool(SharedPreferenceKeyHolder.showItemList);
    _https = _prefs.getBool(SharedPreferenceKeyHolder.https);
    _edgeDetection = _prefs.getBool(SharedPreferenceKeyHolder.detectEdges);
    _showParsedResults = _prefs.getBool(SharedPreferenceKeyHolder.showParsedResults);
  }

  @override
  Widget build(BuildContext context) {
    readFallbackValues();

    return SettingsList(
      key: _scaffoldKey4,
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
              onPressed: (context) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        LanguageSetting(_prefs)));
              },
            ),
            SettingsTile(
              title: S.of(context).apitoken,
              leading: Icon(Icons.vpn_key),
              onPressed: (context) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ApiSettings(_prefs)));
              },
            ),
          ],
        ),
        SettingsSection(title: S.of(context).networkSettings, tiles: [
          SettingsTile(
            title: S.of(context).detectReceiptServer,
            leading: Icon(Icons.adb),
            onPressed: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DiscoverSettings(_prefs)));
            },
          ),
          SettingsTile(
            title: S.of(context).settingsServerTitle,
            leading: Icon(Icons.wifi),
          onPressed: (context) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ServerSettings(_prefs)));
            },
          ),
          SettingsTile.switchTile(
            title: S.of(context).https,
            leading: Icon(Icons.lock),
            switchValue: _https,
            onToggle: (bool value) {
              setState(() {
                _https = value;
                _prefs.setBool("https", value);
              });

              if (!value) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(S.of(context).disableHttpsWarning),
                    backgroundColor: Colors.red,
                  ));
              }
            },
          ),
        ]),
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

                  if (!value && _gaussian) {
                    _gaussian = false;
                    _prefs.setBool("gaussian", false);
                  }
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

                  if (value) {
                    _grayscale = true;
                    _prefs.setBool("grayscale", value);
                  }
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
            SettingsTile.switchTile(
              title: S.of(context).showListView,
              leading: Icon(Icons.category),
              switchValue: _showItemList,
              onToggle: (bool value) {
                setState(() {
                  _showItemList = value;
                  _prefs.setBool("showItemList", value);
                });
              },
            ),
            SettingsTile.switchTile(
              title: S.of(context).detectEdges,
              leading: Icon(Icons.zoom_out_map_outlined),
              switchValue: _edgeDetection,
              onToggle: (bool value) {
                setState(() {
                  _edgeDetection = value;
                  _prefs.setBool(SharedPreferenceKeyHolder.detectEdges, value);
                });
              },
            ),
            SettingsTile.switchTile(
              title: S.of(context).showParsedReceipt,
              leading: Icon(Icons.receipt),
              switchValue: _showParsedResults,
              onToggle: (bool value) {
                setState(() {
                  _showParsedResults = value;
                  _prefs.setBool(SharedPreferenceKeyHolder.showParsedResults, value);
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
              onPressed: (context) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => OssLicensesPage()));
              },
            ),
          ],
        )
      ],
    );
  }
}
