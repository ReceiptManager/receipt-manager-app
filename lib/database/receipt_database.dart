/*
 * Copyright (c) 2020 William Todt
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:developer';

import 'package:moor_flutter/moor_flutter.dart';
import 'package:receipt_parser/model/receipt.dart';
import 'package:receipt_parser/out/receipt_printer.dart';

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

  Future<List<Receipt>> getReceipts() {
    return (select(receipts)
      ..orderBy(([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.shop),
      ])))
        .get();
  }

  Stream<List<Receipt>> watchReceipts() => select(receipts).watch();

  Future<void> insertReceipt(ReceiptsCompanion receipt) {
    Receipt r = Receipt(
        id: receipt.id.value,
        total: receipt.total.value,
        date: receipt.date.value,
        shop: receipt.shop.value,
        category: receipt.category.value);
    log("[-> Insert new receipt" + ReceiptPrinter.print(r));
    return into(receipts).insert(receipt);
  }

  Future deleteDatabase() async {
    delete(receipts).go();
  }

  Future updateReceipt(Receipt receipt) => update(receipts).replace(receipt);

  Future deleteReceipt(Receipt receipt) => delete(receipts).delete(receipt);
}
