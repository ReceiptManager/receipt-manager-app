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

class WeeklyOverview {
  List<Receipt> receipts;
  BuildContext context;

  WeeklyOverview(this.receipts, this.context);

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  List<WeeklyChartData> getData() {
    if (this.receipts == null) return null;
    final List<WeeklyChartData> chartData = [
      WeeklyChartData(1, 0),
      WeeklyChartData(2, 0),
      WeeklyChartData(3, 0),
      WeeklyChartData(4, 0),
      WeeklyChartData(5, 0),
      WeeklyChartData(6, 0),
      WeeklyChartData(7, 0),
    ];

    final _date = DateTime.now();
    final startDate =
        getDate(_date.subtract(Duration(days: _date.weekday - 1)));

    for (Receipt receipt in receipts) {
      for (int i = 0; i < 7; i++) {
        var d =
            new DateTime(startDate.year, startDate.month, startDate.day + i);
        if (receipt.date.year == d.year &&
            receipt.date.month == d.month &&
            receipt.date.day == d.day) {
          double total = double.parse(receipt.total);
          chartData[receipt.date.weekday - 1].total += total;
        }
      }
    }

    return chartData;
  }
}
