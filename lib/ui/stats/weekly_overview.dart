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
import 'package:receipt_manager/db/receipt_database.dart';
import 'package:receipt_manager/ui/stats/weekly_chart_data.dart';
import 'package:receipt_manager/util/total_manipulator.dart';

class WeeklyOverview {
  List<Receipt> receipts;
  BuildContext context;

  WeeklyOverview(this.receipts, this.context);

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  List<WeeklyChartData> getData() {
    if (this.receipts == null) return null;

    DateTime _today = DateTime.now();
    DateTime _start = _today.subtract(new Duration(days: _today.weekday));
    final List<WeeklyChartData> chartData = [];

    for (int i = 1; i < 8; i++) {
      DateTime date = DateTime(_start.year, _start.month, _start.day + i);
      chartData.add(WeeklyChartData(date, 0));
    }

    for (Receipt receipt in receipts) {
      for (int i = 0; i < 7; i++) {
        var d = new DateTime(_start.year, _start.month, _start.day + i);
        if (receipt.date.year == d.year &&
            receipt.date.month == d.month &&
            receipt.date.day == d.day) {
          double total = TotalManipulator.get(receipt.total);
          chartData[receipt.date.weekday - 1].total += total;
        }
      }
    }

    return chartData;
  }
}
