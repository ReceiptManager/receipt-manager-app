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

import 'dart:developer';

import 'package:receipt_manager/api/abstract_api.dart';
import 'package:receipt_manager/database/receipt_database.dart';
import 'package:receipt_manager/math/math_util.dart';
import 'package:receipt_manager/memento/receipt_memento.dart';

class WeeklyApi extends AbstractApi {
  /// The [ReceiptMomentum] is used to store receipts in the list.
  /// This increase the performance, since no additionally database
  /// call is required
  ReceiptMemento _momentum = ReceiptMemento();

  /// Store weekly total and weekly maximum in a double
  double weeklyTotal = 0;
  double weeklyMaximum = 0;

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  /// The [calculateWeekly] method is used to calculated the weekly maximum
  /// and total. This function should not be called from outside. Instead,
  /// the [init] method call the [calculateWeekly] method.
  void execute() {
    final _date = DateTime.now();
    List<double> expenses = [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00];

    weeklyTotal = 0.00;
    weeklyMaximum = 0.00;
    final firstWeekDate =
        getDate(_date.subtract(Duration(days: _date.weekday - 1)));

    for (Receipt receipt in _momentum.receipts) {
      for (int i = 0; i < 7; i++) {
        // create an date object in order to increase the date
        // this allows to keep the code simple and
        // remove edge cases
        var currentDate = new DateTime(
            firstWeekDate.year, firstWeekDate.month, firstWeekDate.day + i);
        if (receipt.date.year == currentDate.year &&
            receipt.date.month == currentDate.month &&
            receipt.date.day == currentDate.day) {
          try {
            expenses[i] += double.parse(receipt.total.replaceAll(" ", ""));
          } catch (e) {
            log("[WARNING]: can't calculate receipt.");
          }
        }
      }

      for (int i = 0; i < 7; i++) {
        expenses[i] = MathUtil.roundDouble(expenses[i], 2);
        weeklyTotal += expenses[i];
      }
    }

    weeklyMaximum =
        expenses.reduce((current, next) => current > next ? current : next);
  }
}
