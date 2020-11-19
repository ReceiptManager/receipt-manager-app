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
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:receipt_manager/converter/color_converter.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServerSettings extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  @override
  _ServerSettingsState createState() => _ServerSettingsState(sharedPreferences);

  ServerSettings(this.sharedPreferences);
}

class _ServerSettingsState extends State<ServerSettings> {
  final _textController = TextEditingController();
  SharedPreferences sharedPreferences;

  _ServerSettingsState(this.sharedPreferences);

  String ipv4 = "";

  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  serverTextfield() {
    return new TextFormField(
      controller: _textController,
      onChanged: (value) {
        ipv4 = value;
      },
      keyboardType: TextInputType.url,
      decoration: new InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor.fromHex("#232F34")),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor.fromHex("#232F34")),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: HexColor.fromHex("#232F34"))),
        hintText: S.of(context).serverIP,
        labelText: S.of(context).serverIPLabelText,
        helperText: S.of(context).serverIPHelpText,
        prefixIcon: const Icon(
          Icons.network_wifi,
        ),
        prefixText: ' ',
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (sharedPreferences.getString("ipv4") != null) {
      ipv4 = sharedPreferences.getString("ipv4");
      _textController.value = TextEditingValue(
        text: ipv4,
        selection: TextSelection.fromPosition(
          TextPosition(offset: ipv4.length),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey2,
      appBar: AppBar(title: Text(S.of(context).serverSettings)),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                new Theme(data: ThemeData.light(), child: serverTextfield())),
        Stack(children: [
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton(
                      onPressed: () async {
                        final ipv4Regex =
                            "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\$";

                        RegExp ipRegex = new RegExp(ipv4Regex,
                            caseSensitive: false, multiLine: false);

                        if (ipv4.isEmpty || !ipRegex.hasMatch(ipv4)) {
                          showDialog(
                              context: context,
                              builder: (_) => AssetGiffyDialog(
                                    image: Image.asset(
                                      "assets/robot.gif",
                                      fit: BoxFit.fill,
                                    ),
                                    title: Text(
                                      'Invalid server ip',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                                    description: Text(
                                      S.of(context).invalidServerIP,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(),
                                    ),
                                    onCancelButtonPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    onOkButtonPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ));
                          return;
                        }

                        sharedPreferences.setString("ipv4", ipv4);
                        _scaffoldKey2.currentState
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content: Text(S.of(context).updateServerIP),
                            backgroundColor: Colors.green,
                          ));
                      },
                      child: Icon(Icons.done_all))))
        ])
      ]),
    );
  }
}
