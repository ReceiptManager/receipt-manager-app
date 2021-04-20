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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';
import 'package:receipt_manager/data/storage/receipt_database.dart';
import 'package:receipt_manager/data/storage/scheme/insert_holder_table.dart';

import 'upload.dart';

class UploadController extends Controller {
  final UploadPresenter _historyPresenter;

  DataReceiptRepository repository;

  UploadController(DataReceiptRepository repository)
      : _historyPresenter = UploadPresenter(repository),
        this.repository = repository,
        super();

  @override
  void initListeners() {}

  @override
  void onResumed() => print('On resumed');

  @override
  void onReassembled() => print('View is about to be reassembled');

  @override
  void onDeactivated() => print('View is about to be deactivated');

  @override
  void onDisposed() {
    _historyPresenter.dispose();
    super.onDisposed();
  }

  Future<void> sendReceipt(File image) async {
    StoresCompanion store = StoresCompanion(storeName: Value("StoreTest"));
    TagsCompanion tag = TagsCompanion(tagName: Value("TagTest"));
    CategoriesCompanion categoriesCompanion =
        CategoriesCompanion(categoryName: Value("Category"));
    ReceiptsCompanion receipt = ReceiptsCompanion(
      date: Value(DateTime.now()),
      total: Value(19.00),
      currency: Value("\$"),
    );

    InsertReceiptHolder receiptHolder = InsertReceiptHolder(
        tag: tag,
        store: store,
        category: categoriesCompanion,
        receipt: receipt);

    Navigator.of(getContext()).pop({'receipt': receiptHolder});
  }
}
