import 'dart:ui';

import 'package:receipt_parser/db/receipt_category.dart';

class Receipt {
  final String name;
  final ReceiptCategory category;
  final DateTime date;
  final double total;
  final Color color;

  Receipt({this.name, this.category, this.date, this.color, this.total});
}
