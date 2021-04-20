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

class MonthlyOverview {
  final List<ReceiptHolder> receipts;

  MonthlyOverview(this.receipts);

  List<ReceiptMonthData> getData() {
    final List<ReceiptMonthData> chartData = [
      ReceiptMonthData(1, 0),
      ReceiptMonthData(2, 0),
      ReceiptMonthData(3, 0),
      ReceiptMonthData(4, 0),
      ReceiptMonthData(5, 0),
      ReceiptMonthData(6, 0),
      ReceiptMonthData(7, 0),
      ReceiptMonthData(8, 0),
      ReceiptMonthData(9, 0),
      ReceiptMonthData(10, 0),
      ReceiptMonthData(11, 0),
      ReceiptMonthData(12, 0),
    ];

    for (ReceiptHolder holder in receipts) {
      Receipt r = holder.receipt;
      if (r.date.year != DateTime.now().year) continue;
      double total = r.total;
      chartData[r.date.month].total += total;
    }

    return chartData;
  }
}
