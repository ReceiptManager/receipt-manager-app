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

import 'package:receipt_manager/app/pages/stats/stat_view.dart';
import 'package:receipt_manager/data/storage/receipt_database.dart';
import 'package:receipt_manager/data/storage/scheme/holder_table.dart';

class CategoryOverview {
  final List<ReceiptHolder> receipts;

  CategoryOverview(this.receipts);

  List<CategoryData> getData() {
    List<CategoryData> chartData = [];

    for (ReceiptHolder holder in receipts) {
      final Receipt receipt = holder.receipt;
      final Categorie categorie = holder.categorie;
      if (receipt.date.year != DateTime.now().year) continue;

      if (chartData.isEmpty) {
        chartData.add(CategoryData(categorie.categoryName, receipt.total));
      } else {
        List<CategoryData>? list = chartData
            .where((element) => element.label == categorie.categoryName)
            .toList();

        if (list.isEmpty) {
          chartData.add(CategoryData(categorie.categoryName, receipt.total));
        } else {
          int pos = chartData.indexOf(list.first);

          chartData[pos] = CategoryData(
              categorie.categoryName, chartData[pos].total + receipt.total);
        }
      }
    }

    return chartData;
  }
}
