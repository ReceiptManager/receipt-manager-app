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

import 'package:receipt_manager/api/weekly_api.dart';

/// # Expenses API
/// The expenses api handle various of expenses calculation tasks.
/// The [ExpensesApi] uses an singleton in order to submit
/// the same object.
///
/// First an initial call needs to be made, in order to calculate weekly expenses
/// and maximum but additionally, other features are planned.
class ExpensesApi {
  WeeklyApi weeklyApi = WeeklyApi();

  /// Store weekly total and weekly maximum in a double
  double weeklyTotal = 0;
  double weeklyMaximum = 0;

  /// Print double in fixed length
  String format(double amount, int decimalPlaces) {
    return amount.toStringAsFixed(decimalPlaces);
  }

  /// # API init method
  /// Main entry point of the expenses api.
  void init() {
    weeklyApi.execute();

    weeklyTotal = weeklyApi.weeklyTotal;
    weeklyMaximum = weeklyApi.weeklyMaximum;
  }
}
