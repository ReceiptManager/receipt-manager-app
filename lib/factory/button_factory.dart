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
import 'package:intl/intl.dart';
import 'package:receipt_manager/generated/l10n.dart';

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
              lastDate: DateTime(2030));
          dateController.text =
              DateFormat(S.of(context).receiptDateFormat).format(receiptDate);
        });
  }
}
