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
                    child: Text('${licence[index]}',
                  style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w300),
                )),
              );
            }));
  }
}
