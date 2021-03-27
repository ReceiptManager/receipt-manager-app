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

  String _token = "";

  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  serverTextfield() {
    return new TextFormField(
      controller: _textController,
      onChanged: (value) {
        _token = value;
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
        hintText: S.of(context).insertYourApiToken,
        //labelText: S.of(context).apitoken,
        helperText: S.of(context).insertServerApiToken,
        prefixIcon: const Icon(
          Icons.vpn_key,
        ),
        prefixText: ' ',
      ),
    );
  }

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey2 = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    if (sharedPreferences.getString("api_token") != null) {
      _token = sharedPreferences.getString("api_token");
      _textController.value = TextEditingValue(
        text: _token,
        selection: TextSelection.fromPosition(
          TextPosition(offset: _token.length),
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
                        sharedPreferences.setString("api_token", _token);
                        _scaffoldKey2.currentState
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content:
                                Text(S.of(context).updateApiTokenSuccessfully),
                            backgroundColor: Colors.green,
                          ));
                      },
                      child: Icon(Icons.done_all))))
        ])
      ]),
    );
  }
}
