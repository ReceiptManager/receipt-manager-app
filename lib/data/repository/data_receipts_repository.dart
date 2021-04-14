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
import 'package:receipt_manager/domain/repository/abstract_repository.dart';

class DataReceiptRepository extends ReceiptRepository {
  static final DataReceiptRepository _instance =
      DataReceiptRepository._internal();

  DataReceiptRepository._internal();

  factory DataReceiptRepository() => _instance;

  ReceiptDao _dao = ReceiptDao(AppDatabase());

  Stream<List<Receipt>> watchReceipts() => _dao.watchReceipts();

  Future insertReceipt(ReceiptsCompanion receipt) =>
      _dao.insertReceipt(receipt);

  Future updateReceipt(Receipt receipt) => _dao.updateReceipt(receipt);

  Future deleteReceipt(Receipt receipt) => _dao.deleteReceipt(receipt);

  Future deleteDatabase() => _dao.deleteDatabase();

  @override
  Stream<List<ReceiptHolder>> getReceipts() => _dao.getReceipts();
}
