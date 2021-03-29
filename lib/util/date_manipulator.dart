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

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:receipt_manager/generated/l10n.dart';

class DateManipulator {
  static String humanDate2(DateTime dateTime, String formatString) {
    if (dateTime == null) return "";
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;

    year = year < 100 ? DateTime.now().year : year;
    return DateFormat(formatString).format(DateTime.utc(year, month, day));
  }

  static String humanDate(BuildContext context, DateTime dateTime) {
    if (dateTime == null) return "";
    return humanDate2(dateTime, S.of(context).receiptDateFormat);
  }
}
