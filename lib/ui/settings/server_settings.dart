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
import 'package:giffy_dialog/giffy_dialog.dart';
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
        filled: true,
        fillColor: Colors.grey[100],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[100]),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey[100])),
        hintText: S.of(context).serverIP,
        // labelText: S.of(context).serverIPLabelText,
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
        Padding(padding: const EdgeInsets.all(16.0), child: serverTextfield()),
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
                                      "assets/server_down.png",
                                      fit: BoxFit.fill,
                                    ),
                                    title: Text(
                                      'Invalid server IP',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                                    description: Text(
                                      S.of(context).invalidServerIP,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w100),
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
