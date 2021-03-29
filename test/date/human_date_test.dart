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
import 'package:receipt_manager/util/date_manipulator.dart';

void main() {
  String format = "dd.MM.y";
  test("Test Human date formatter", () {
    DateTime date = DateTime.utc(21, 03, 29);
    expect(DateManipulator.humanDate2(date, format), "29.03.2021");
  });
}