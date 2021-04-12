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

import 'package:moor_flutter/moor_flutter.dart';
import 'package:receipt_manager/data/storage/scheme/receipt.dart';

export 'package:moor_flutter/moor_flutter.dart' show Value;

part 'receipt_database.g.dart';

@UseMoor(tables: [Receipts, Stores], daos: [ReceiptDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sql", logStatements: true));

  int get schemaVersion => 10;
}

@UseDao(tables: [Receipts, Stores])
class ReceiptDao extends DatabaseAccessor<AppDatabase> with _$ReceiptDaoMixin {
  final AppDatabase db;

  ReceiptDao(this.db) : super(db);

  Future<List<Receipt>> getReceipts() {
    return (select(receipts)
          ..orderBy(([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ])))
        .get();
  }

  Stream<List<Receipt>> watchReceipts() => select(receipts).watch();

  Future<void> insertReceipt(ReceiptsCompanion receipt) {
    return into(receipts).insert(receipt);
  }

  Future deleteDatabase() async {
    delete(receipts).go();
  }

  Future updateReceipt(Receipt receipt) => update(receipts).replace(receipt);

  Future deleteReceipt(Receipt receipt) => delete(receipts).delete(receipt);
}
