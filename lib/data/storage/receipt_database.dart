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

import 'dart:developer';

import 'package:moor_flutter/moor_flutter.dart';
import 'package:receipt_manager/data/storage/scheme/category_table.dart';
import 'package:receipt_manager/data/storage/scheme/holder_table.dart';
import 'package:receipt_manager/data/storage/scheme/insert_holder_table.dart';
import 'package:receipt_manager/data/storage/scheme/receipt_table.dart';
import 'package:receipt_manager/data/storage/scheme/store_table.dart';
import 'package:receipt_manager/data/storage/scheme/tag_table.dart';

export 'package:moor_flutter/moor_flutter.dart' show Value;

part 'receipt_database.g.dart';

@UseMoor(tables: [Receipts, Stores, Tags, Categories], daos: [ReceiptDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sql", logStatements: true));

  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    });
  }
}

@UseDao(tables: [Receipts, Stores, Tags, Categories])
class ReceiptDao extends DatabaseAccessor<AppDatabase> with _$ReceiptDaoMixin {
  final AppDatabase db;

  ReceiptDao(this.db) : super(db);

  Stream<List<ReceiptHolder>> getReceipts() {
    return (select(receipts)
          ..orderBy(([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ])))
        .join([
          innerJoin(categories, categories.id.equalsExp(receipts.categoryId)),
          innerJoin(stores, stores.id.equalsExp(receipts.storeId)),
          innerJoin(tags, tags.id.equalsExp(receipts.tagId)),
        ])
        .watch()
        .map(
          (rows) => rows.map(
            (row) {
              return ReceiptHolder(
                store: row.readTable(stores),
                tag: row.readTable(tags),
                receipt: row.readTable(receipts),
                categorie: row.readTable(categories),
              );
            },
          ).toList(),
        );
  }

  Future<void> insertReceipt(InsertReceiptHolder holder) async {
    int storeId = await into(stores).insert(holder.store);
    int tagId = await into(tags).insert(holder.tag);
    int categoryId = await into(categories).insert(holder.category);

    log("Insert store id: " + storeId.toString());
    log("Insert tag id: " + tagId.toString());

    into(receipts).insert(holder.receipt.copyWith(
        storeId: Value(storeId),
        tagId: Value(tagId),
        categoryId: Value(categoryId)));
  }

  Future deleteDatabase() async {
    delete(receipts).go();
    delete(stores).go();
    delete(tags).go();
    delete(categories).go();
  }

  Future updateReceipt(ReceiptHolder holder) async {}

  Future deleteReceipt(ReceiptHolder holder) async {
    return delete(receipts).delete(holder.receipt);
  }

  Future<List<Store>> getStoreNames() {
    return select(stores).get();
  }

  Future<List<Tag>> getTagNames() {
    return select(tags).get();
  }

  Future<List<Categorie>> getCategoryNames() {
    return select(categories).get();
  }
}
