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

import 'package:receipt_manager/database/receipt_database.dart';
import 'package:receipt_manager/factory/categories_factory.dart';
import 'package:receipt_manager/model/receipt_category.dart';
import 'package:receipt_manager/stats/category.dart';

class CategoryOverview {
  final List<Receipt> receipts;

  CategoryOverview(this.receipts);

  List<CategoryData> getData() {
    if (receipts == null) return null;
    List<CategoryData> chartData = [];
    for (ReceiptCategory category in ReceiptCategoryFactory.categories) {
      chartData.add(CategoryData(category.name, 0));
    }

    for (Receipt receipt in receipts) {
      if (receipt.date.year != DateTime.now().year) continue;

      int i = 0;
      for (CategoryData categoryData in chartData) {
        Map<String, dynamic> json = jsonDecode(receipt.category);

        if (json['name'] == categoryData.label) {
          double total = double.parse(receipt.total);
          if (total < 0) {
            total = -total;
          }

          chartData[i].total += total;
        }
        i++;
      }
    }

    chartData.removeWhere((element) => element.total == 0.00);
    return chartData;
  }
}
