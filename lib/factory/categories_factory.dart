import 'package:flutter/material.dart';
import 'package:receipt_parser/model/receipt_category.dart';

class ReceiptCategoryFactory {
  static List<ReceiptCategory> get() {
    return <ReceiptCategory>[
      const ReceiptCategory(
          'Grocery', Icon(Icons.shopping_bag_outlined, color: Colors.white)),
      const ReceiptCategory(
          'Education', Icon(Icons.school, color: Colors.white)),
      const ReceiptCategory(
          'Books', Icon(Icons.book_rounded, color: Colors.white)),
      const ReceiptCategory('Entertainment',
          Icon(Icons.accessibility_new_outlined, color: Colors.white)),
      const ReceiptCategory('Health', Icon(Icons.healing, color: Colors.white)),
      const ReceiptCategory('Car', Icon(Icons.car_repair, color: Colors.white)),
    ];
  }
}
