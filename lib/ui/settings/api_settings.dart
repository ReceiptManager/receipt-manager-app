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

class ApiSettings extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  @override
  _ApiSettingsState createState() => _ApiSettingsState(sharedPreferences);

  ApiSettings(this.sharedPreferences);
}

class _ApiSettingsState extends State<ApiSettings> {
  final _textController = TextEditingController();
  SharedPreferences sharedPreferences;

  _ApiSettingsState(this.sharedPreferences);

  String api_token = "";

  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  serverTextfield() {
    return new TextFormField(
      controller: _textController,
      onChanged: (value) {
        api_token = value;
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
        hintText: S.of(context).insertYourApiToken,
        labelText: S.of(context).apitoken,
        helperText: S.of(context).insertServerApiToken,
        prefixIcon: const Icon(
          Icons.vpn_key,
        ),
        prefixText: ' ',
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (sharedPreferences.getString("api_token") != null) {
      api_token = sharedPreferences.getString("api_token");
      _textController.value = TextEditingValue(
        text: api_token,
        selection: TextSelection.fromPosition(
          TextPosition(offset: api_token.length),
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

                        sharedPreferences.setString("api_token", api_token);
                        _scaffoldKey2.currentState
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content: Text(S.of(context).updateApiTokenSuccessfully),
                            backgroundColor: Colors.green,
                          ));
                      },
                      child: Icon(Icons.done_all))))
        ])
      ]),
    );
  }
}
