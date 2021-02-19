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
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:receipt_manager/generated/l10n.dart';

class OpenSourceSettings extends StatefulWidget {
  @override
  _OpenSourceSettingsState createState() => _OpenSourceSettingsState();
}

class _OpenSourceSettingsState extends State<OpenSourceSettings> {
  var licence = [
    "camera: ^0.5.8+9",
    "path_provider:",
    "path: 1.1.0",
    "curved_navigation_bar: ^0.3.4",
    "shared_preferences:  ^0.5.12+2",
    "giffy_dialog: ^1.8.0",
    "flutter_bloc: ^6.0.6",
    "equatable: ^1.2.5",
    "moor_flutter: ^3.1.0",
    "flutter_slidable: ^0.5.7",
    "moor: ^3.3.1",
    "cupertino_icons: ^1.0.0",
    "intl: ^0.16.1",
    "settings_ui: ^0.4.0",
    "flutter_staggered_grid_view: ^0.3.2",
    "permission_handler: ^5.0.1+1",
    "fl_chart: ^0.12.0",
    "image: ^2.1.18",
    "progress_dialog: ^1.2.4",
    "rounded_loading_button: ^1.0.0",
    "simple_autocomplete_formfield: ^0.2.7",
    "flutter_onboard: ^0.1.0",
    "provider: ^4.3.2+2",
    "random_color: ^1.0.5",
    "simple_animations: ^2.2.2",
    "random_date: ^0.0.5",
  ];

  @override
  void initState() {
    log(Intl.getCurrentLocale());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(S.of(context).openSourceLicence)),
        body: ListView.builder(
            itemCount: licence.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 40,
                color: Colors.white,
                child: Center(
                    child: Text(
                  '${licence[index]}',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                )),
              );
            }));
  }
}
