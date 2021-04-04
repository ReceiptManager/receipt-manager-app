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

import 'package:moor/moor.dart';

class Receipts extends Table {
  IntColumn get id => integer().autoIncrement()();

  // TODO: add contraints
  IntColumn get storeName => integer().nullable();

  RealColumn get total => real()();

  IntColumn get currency => integer();

  DateTimeColumn get date => dateTime()();

  // TODO: add constraints
  IntColumn get tag => integer().nullable();

  // TODO: add constraints
  IntColumn get items => integer().nullable();
}

class Tag extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get tag => text()();
}

class Currency extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get currency => text()();
}

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  RealColumn get total => real()();
}

class Store extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();
}
