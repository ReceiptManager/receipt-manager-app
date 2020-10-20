/*
 * Copyright (c) 2020 William Todt
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:receipt_parser/generated/l10n.dart';

/// Since most of the buttons use the same style
/// The factory create a unique button with the custom style.
class ButtonFactory {
  static IconButton buildDateButton(DateTime receiptDate,
      TextEditingController dateController, BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.calendar_today,
          color: Colors.purple,
        ),
        splashColor: Colors.black,
        color: Colors.black,
        onPressed: () async {
          receiptDate = await showDatePicker(
              builder: (BuildContext context, Widget child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: Colors.black,
                    accentColor: Colors.black,
                    colorScheme:
                        ColorScheme.light(primary: const Color(0XFFF9AA33)),
                    buttonTheme:
                        ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child,
                );
              },
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2010),
              lastDate: DateTime(2050));
          dateController.text =
              DateFormat(S.of(context).receiptDateFormat).format(receiptDate);
        });
  }
}
