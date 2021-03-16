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

import 'package:receipt_manager/database/receipt_database.dart';
import 'package:receipt_manager/stats/abstract_chart_data.dart';
import 'package:receipt_manager/stats/abstract_overview.dart';
import 'package:receipt_manager/stats/chart_data_month.dart';
import 'package:receipt_manager/stats/monthly_overview.dart';
import "package:test/test.dart";

void main() {
  List<Receipt> receipts = [];
  MonthlyOverview overview;
  DateTime date = DateTime.now();

  group("Monthly Test", () {
    test("Non null test", () {
      MonthlyOverview overview = MonthlyOverview(null);
      expect(overview.getData(), null);
    });

    test("Calculation test", () {
      DateTime date = DateTime.now();

      receipts = [
        Receipt(id: (0), total: "1.00", shop: null, category: null, date: date),
        Receipt(id: (1), total: "1.00", shop: null, category: null, date: date)
      ];

      MonthlyOverview overview = MonthlyOverview(receipts);
      List<ReceiptMonthData> data = overview.getData();
      expect(data.elementAt(date.month).total, 2.00);
    });

    receipts = [
      Receipt(id: (0), total: "1.00", shop: null, category: null, date: DateTime.now()),
      Receipt(id: (1), total: "1.00", shop: null, category: null, date: new DateTime(2018, 1, 13))
    ];

    overview = MonthlyOverview(receipts);
    test("Calculation edge case test", () {
      expect(overview.getData().elementAt(date.month).total, 1.00);
    });
  });
}
