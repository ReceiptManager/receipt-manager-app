import 'package:flutter/material.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';
import 'package:receipt_parser/ui/settings/developer_settings.dart';
import 'package:receipt_parser/ui/settings/environment_setting.dart';
import 'package:receipt_parser/ui/settings/server_settings.dart';
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
            title: 'Common',
            // titleTextStyle: TextStyle(fontSize: 30),
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LanguageSetting()));
                },
              ),
              SettingsTile(
                title: 'Environment',
                subtitle: 'Production',
                leading: Icon(Icons.cloud_queue),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => EnvironmentSetting()));
                },
              ),
              SettingsTile(
                title: 'Developer',
                subtitle: 'Developer utils',
                leading: Icon(Icons.adb_rounded),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DeveloperSettings(_bloc)));
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'Network',
            tiles: [
              SettingsTile(
                title: 'Server',
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
            title: 'Development',
            tiles: [
              SettingsTile.switchTile(
                title: 'Enable debug output',
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
            title: 'Misc',
            tiles: [
              SettingsTile(
                  title: 'Open source licenses',
                  leading: Icon(Icons.collections_bookmark)),
            ],
          )
        ],
      ),
    );
  }
}
