import 'dart:core';

import 'package:receipt_manager/database/receipt_database.dart';

class ReceiptMemento {
  static final ReceiptMemento _receiptShare = ReceiptMemento._internal();

  List<Receipt> receipts;
  List<Receipt> finalReceipts;

  factory ReceiptMemento() {
    return _receiptShare;
  }

  ReceiptMemento._internal();

  void store(List<Receipt> receipts) {
    this.finalReceipts = receipts;
    this.receipts = receipts;
  }
}