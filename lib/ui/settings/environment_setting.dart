import 'package:flutter/material.dart';
import 'package:receipt_parser/theme/theme_manager.dart';
import 'package:settings_ui/settings_ui.dart';

class EnvironmentSetting extends StatefulWidget {
  @override
  _EnvironmentSettingState createState() => _EnvironmentSettingState();
}

class _EnvironmentSettingState extends State<EnvironmentSetting> {
  int environmentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Environment')),
      body: SettingsList(
        sections: [
          SettingsSection(tiles: [
            SettingsTile(
                title: "Debug",
                leading: trailingWidget(0),
                onTap: () {
                  changeEnvironment(0);
                }),
          ]),
        ],
      ),
    );
  }

  Widget trailingWidget(int index) {
    return (environmentIndex == index)
        ? Icon(Icons.check, color: ThemeManager.getYellow())
        : Icon(null);
  }

  void changeEnvironment(int index) {
    setState(() {
      environmentIndex = index;
    });
  }
}
