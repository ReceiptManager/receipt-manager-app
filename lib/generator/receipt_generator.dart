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
