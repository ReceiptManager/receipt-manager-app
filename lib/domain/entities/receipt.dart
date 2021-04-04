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

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get price => integer()();
}

class Receipts extends Table {
  IntColumn get id => integer().autoIncrement()();
}

@DataClassName('ReceiptEntry')
class ShoppingCartEntries extends Table {
  IntColumn get receipt => integer()();
  IntColumn get item => integer()();
}

class ReceiptWithItems {
  final Receipts receipt;
  final List<Items> items;

  ReceiptWithItems(this.receipt, this.items);
}
