import 'package:flutter/material.dart';
import 'package:receipt_parser/model/receipt_category.dart';

class ReceiptCategoryFactory {
  static List<ReceiptCategory> get() {
    return <ReceiptCategory>[
      const ReceiptCategory('Grocery', Icon(Icons.shopping_bag_outlined)),
      const ReceiptCategory('Health', Icon(Icons.medical_services)),
    ];
  }
}
