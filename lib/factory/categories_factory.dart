import 'package:flutter/material.dart';
import 'package:receipt_parser/model/receipt_category.dart';

class ReceiptCategoryFactory {
  static List<ReceiptCategory> get() {
    return <ReceiptCategory>[
      const ReceiptCategory(
          'Grocery', Icon(Icons.shopping_bag_outlined, color: Colors.black)),
      const ReceiptCategory(
          'Education', Icon(Icons.school, color: Colors.black)),
      const ReceiptCategory(
          'Book', Icon(Icons.book_rounded, color: Colors.black)),
      const ReceiptCategory('Entertainment',
          Icon(Icons.accessibility_new_outlined, color: Colors.black)),
      const ReceiptCategory('Health', Icon(Icons.healing, color: Colors.black)),
      const ReceiptCategory(
          'Restaurant', Icon(Icons.fastfood, color: Colors.black)),
      const ReceiptCategory(
          'Transport', Icon(Icons.train, color: Colors.black)),
      const ReceiptCategory('Sell', Icon(Icons.train, color: Colors.black)),
      const ReceiptCategory(
          'Other', Icon(Icons.add_to_photos_rounded, color: Colors.black)),
      const ReceiptCategory(
          'Drugstore', Icon(Icons.shopping_cart_outlined, color: Colors.black)),
    ];
  }
}
