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

import 'package:receipt_manager/data/storage/receipt_database.dart';
import 'package:receipt_manager/data/storage/scheme/holder_table.dart';
import 'package:receipt_manager/data/storage/scheme/insert_holder_table.dart';

abstract class ReceiptRepository {
  Stream<List<ReceiptHolder>> getReceipts();

  Future insertReceipt(InsertReceiptHolder receipt);

  Future updateReceipt(ReceiptHolder receipt);

  Future deleteReceipt(ReceiptHolder receipt);

  Future deleteDatabase();

  Future<List<Store>> getStoreNames();

  Future<List<Tag>> getTagNames();

  Future<List<Categorie>> getCategoryNames();
}
