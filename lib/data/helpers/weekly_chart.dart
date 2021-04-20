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
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import 'package:receipt_manager/app/widgets/stats/stats_card.dart';
import 'package:receipt_manager/data/storage/receipt_database.dart';
import 'package:receipt_manager/data/storage/scheme/holder_table.dart';

class WeeklyOverview {
  List<ReceiptHolder> receipts;

  WeeklyOverview(this.receipts);

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  List<WeeklyChartData> getData() {
    DateTime _today = DateTime.now();
    DateTime _start = _today.subtract(new Duration(days: _today.weekday));
    final List<WeeklyChartData> chartData = [];

    for (int i = 1; i < 8; i++) {
      DateTime date = DateTime(_start.year, _start.month, _start.day + i);
      chartData.add(WeeklyChartData(date, 0));
    }

    for (ReceiptHolder holder in receipts) {
      final Receipt receipt = holder.receipt;
      for (int i = 0; i < 7; i++) {
        var d = new DateTime(_start.year, _start.month, _start.day + i);
        if (receipt.date.year == d.year &&
            receipt.date.month == d.month &&
            receipt.date.day == d.day) {
          double total = receipt.total;
          chartData[receipt.date.weekday - 1].total += total;
        }
      }
    }

    return chartData;
  }
}
