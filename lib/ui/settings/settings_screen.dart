import 'package:flutter/material.dart';
import 'package:receipt_parser/ui/settings/environment_setting.dart';
import 'package:receipt_parser/ui/settings/server_setting.dart';
import 'package:settings_ui/settings_ui.dart';

import 'language_setting.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool enableDebugOutput = true;
  bool notificationsEnabled = true; 

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
            ],
          ),
          SettingsSection(
            title: 'Network',
            tiles: [
              SettingsTile(title: 'Server', leading: Icon(Icons.wifi),onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ServerSetting()));
              },),
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
