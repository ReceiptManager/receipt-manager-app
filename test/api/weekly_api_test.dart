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

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:receipt_manager/api/weekly_api.dart';
import 'package:receipt_manager/db/memento/memento.dart';
import 'package:receipt_manager/db/receipt_database.dart';
import 'package:receipt_manager/ui/stats/weekly_chart_data.dart';
import 'package:receipt_manager/ui/stats/weekly_overview.dart';

void main() {
  test("Empty memento test", () {
    WeeklyApi api = WeeklyApi();
    api.execute();
  });

  Memento _memento = Memento();
  List<Receipt> receipts = [];
  for (int i = 0; i < 7; i++) {
    DateTime d = DateTime.utc(2021, 3, 22 + i);
    receipts.add(new Receipt(
        id: i, total: "12.00", shop: "DebugStore", date: d, category: null));
  }
  _memento.store(receipts);

  WeeklyApi api = WeeklyApi();
  api.execute();

  test("Weekly API sum check", () {
    double weeklyTotal = api.weeklyTotal;
    expect(weeklyTotal, 7 * 12.00);
  });

  test("Receipt in other week check", () {
    receipts.add(new Receipt(
        id: 9,
        total: "12.00",
        shop: "DebugStore",
        date: DateTime.utc(2021, 3, 29),
        category: null));

    _memento.store(receipts);
    api = WeeklyApi();
    api.execute();

    double weeklyTotal = api.weeklyTotal;
    expect(weeklyTotal, 7 * 12.00);
  });

  test("Check correct date format", () {
    DateTime date = DateTime.utc(2021, 3, 29);
    expect(DateFormat.E().format(date), "Mon");

    receipts = [];
    receipts.add(new Receipt(
        id: 1,
        total: "12.00",
        shop: "DebugStore",
        date: DateTime.utc(2021, 3, 29),
        category: null));

    _memento.store(receipts);
    WeeklyOverview overview = WeeklyOverview(receipts, null);
    List<WeeklyChartData> data = overview.getData();

    expect(data.where((element) => element.total != 0).length, 1);
  });
}
