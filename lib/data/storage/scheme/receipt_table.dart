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

import 'package:moor_flutter/moor_flutter.dart';

class Receipts extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get storeId =>
      integer().customConstraint('NOT NULL REFERENCES stores(id)')();

  DateTimeColumn get date => dateTime()();

  RealColumn get total => real()();

  TextColumn get currency => text()();

  IntColumn get tagId =>
      integer().nullable().customConstraint('REFERENCES tags(id)')();

  IntColumn get categoryId =>
      integer().customConstraint('NOT NULL REFERENCES categories(id)')();
}
