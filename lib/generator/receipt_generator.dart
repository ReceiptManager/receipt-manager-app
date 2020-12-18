import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:random_date/random_date.dart';
import 'package:receipt_manager/database/receipt_database.dart';
import 'package:receipt_manager/factory/categories_factory.dart';
import 'package:receipt_manager/model/receipt_category.dart';

/// The receipt generator is used to generate random
/// receipts. It is used for preview and testing.
class ReceiptGenerator {
  ReceiptGenerator(this.context);

  BuildContext context;

  Random random;
  List<ReceiptCategory> categories;

  void init() {
    categories = ReceiptCategoryFactory.get(context);
    random = Random();
  }

  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;

  ReceiptsCompanion get() {
    double doubleInRange(Random source, num start, num end) =>
        source.nextDouble() * (end - start) + start;

    var randomDate = RandomDate.withStartYear(2000);
    return ReceiptsCompanion(
        total: Value(doubleInRange(random, 12, 1000).toStringAsFixed(2)),
        date: Value(randomDate.random()),
        category: Value(
            jsonEncode(categories[random.nextInt(categories.length - 1)])),
        shop: Value("Test Store"));
  }
}
