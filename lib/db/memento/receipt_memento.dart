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

import 'dart:core';

import 'package:receipt_manager/db/receipt_database.dart';

class ReceiptMemento {
  static final ReceiptMemento _receiptShare = ReceiptMemento._internal();

  List<Receipt> receipts;
  List<Receipt> finalReceipts;
  String currency;

  factory ReceiptMemento() {
    return _receiptShare;
  }

  ReceiptMemento._internal();

  void store(List<Receipt> receipts) {
    this.finalReceipts = receipts;
    this.receipts = receipts;
  }

  void delete(Receipt receipt) {
    this.finalReceipts.remove(receipts);
    this.receipts.remove(receipts);
  }

  void update(Receipt receipt) {
    receipts[receipts.indexWhere((element) => element.id == receipt.id)] =
        receipt;
    finalReceipts[finalReceipts
        .indexWhere((element) => element.id == receipt.id)] = receipt;
  }
}
