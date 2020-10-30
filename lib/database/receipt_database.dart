/*
 *  Copyright (c) 2020 - William Todt
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:moor_flutter/moor_flutter.dart';
import 'package:receipt_manager/model/receipt.dart';

export 'package:moor_flutter/moor_flutter.dart' show Value;

part 'receipt_database.g.dart';

@UseMoor(tables: [Receipts], daos: [ReceiptDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sql", logStatements: true));

  int get schemaVersion => 1;
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
