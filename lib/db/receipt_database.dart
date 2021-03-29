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
import 'package:receipt_manager/db/model/receipt.dart';

export 'package:moor_flutter/moor_flutter.dart' show Value;

part 'receipt_database.g.dart';

@UseMoor(tables: [Receipts], daos: [ReceiptDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sql", logStatements: true));

  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1 && to == 2) {
          await m.addColumn(receipts, receipts.items);
        } 
        
        if (from == 2 && to == 3) {
          await m.addColumn(receipts, receipts.tag);
        }

        if (from <= 3 && to == 4) {

        }
      });
}

@UseDao(tables: [Receipts])
class ReceiptDao extends DatabaseAccessor<AppDatabase> with _$ReceiptDaoMixin {
  final AppDatabase db;

  ReceiptDao(this.db) : super(db);

  /// Perform fetch receipts event in database.
  Future<List<Receipt>> getReceipts() {
    return (select(receipts)
          ..orderBy(([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.shop),
          ])))
        .get();
  }

  Stream<List<Receipt>> watchReceipts() => select(receipts).watch();

  /// Perform insert event in database.
  Future<void> insertReceipt(ReceiptsCompanion receipt) {
    return into(receipts).insert(receipt);
  }

  /// Delete database.
  Future deleteDatabase() async {
    delete(receipts).go();
  }

  /// Perform update event in database.
  Future updateReceipt(Receipt receipt) => update(receipts).replace(receipt);

  /// Perform delete event in database.
  Future deleteReceipt(Receipt receipt) => delete(receipts).delete(receipt);
}
