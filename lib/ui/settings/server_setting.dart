import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class ServerSetting extends StatefulWidget {
  @override
  _ServerSettingState createState() => _ServerSettingState();
}

class _ServerSettingState extends State<ServerSetting> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Server settings')),
      body: Container()
    );
  }
}
