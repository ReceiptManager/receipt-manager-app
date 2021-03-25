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

import 'package:receipt_manager/db/receipt_database.dart';

class Repository {
  ReceiptDao _dao = ReceiptDao(AppDatabase());

  Future<List<Receipt>> getReceipts() => _dao.getReceipts();

  Stream<List<Receipt>> watchReceipts() => _dao.watchReceipts();

  Future insertReceipt(ReceiptsCompanion receipt) =>
      _dao.insertReceipt(receipt);

  Future updateReceipt(Receipt receipt) => _dao.updateReceipt(receipt);

  Future deleteReceipt(Receipt receipt) => _dao.deleteReceipt(receipt);

  Future deleteDatabase() => _dao.deleteDatabase();
}
