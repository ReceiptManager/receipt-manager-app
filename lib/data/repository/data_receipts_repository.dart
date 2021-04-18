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
import 'package:receipt_manager/domain/repository/abstract_repository.dart';

class DataReceiptRepository extends ReceiptRepository {
  static final DataReceiptRepository _instance =
      DataReceiptRepository._internal();

  DataReceiptRepository._internal();

  factory DataReceiptRepository() => _instance;

  ReceiptDao _dao = ReceiptDao(AppDatabase());

  @override
  Future insertReceipt(InsertReceiptHolder receipt) =>
      _dao.insertReceipt(receipt);

  @override
  Future updateReceipt(ReceiptHolder receipt) => _dao.updateReceipt(receipt);

  @override
  Future deleteReceipt(ReceiptHolder receipt) => _dao.deleteReceipt(receipt);

  @override
  Future deleteDatabase() => _dao.deleteDatabase();

  @override
  Stream<List<ReceiptHolder>> getReceipts() => _dao.getReceipts();

  @override
  Future<List<Store>> getStoreNames() => _dao.getStoreNames();

  @override
  Future<List<Tag>> getTagNames() => _dao.getTagNames();

  @override
  Future<List<Categorie>> getCategoryNames() => _dao.getCategoryNames();
}
