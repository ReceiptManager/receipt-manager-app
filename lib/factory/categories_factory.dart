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

import 'package:flutter/material.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/db/model/receipt_category.dart';

class ReceiptCategoryFactory {

  // initialise category only once
  static List<ReceiptCategory> categories;

  static List<ReceiptCategory> get(BuildContext context) {
    if (categories == null) {
      categories = <ReceiptCategory>[
        ReceiptCategory(
            S.of(context).groceryCategory,
            Icon(Icons.shopping_bag_outlined,
                color: Colors.red),
            "grocery"),
        ReceiptCategory(
            S.of(context).healthCategory,
            Icon(Icons.medical_services,
                color: Colors.blue),
            "health"),
        ReceiptCategory(
            S.of(context).Rent,
            Icon(Icons.store_mall_directory,
                color: Colors.green),
            "rent"),
        ReceiptCategory(
            S.of(context).food,
            Icon(Icons.shop,
                color: Colors.yellow),
            "food"),
        ReceiptCategory(
            S.of(context).entertainment,
            Icon(Icons.fastfood_sharp,
                color: Colors.purple),
            "entertainment"),
        ReceiptCategory(
            S.of(context).employeeBenefits,
            Icon(Icons.people,
                color: Colors.orange),
            "employees"),
        ReceiptCategory(
            S.of(context).util,
            Icon(Icons.edit_location_outlined,
                color:Colors.brown),
            "util"),
        ReceiptCategory(
            S.of(context).travel,
            Icon(Icons.airplanemode_active,
                color: Colors.deepOrange),
            "globe"),
        ReceiptCategory(
            S.of(context).education,
            Icon(Icons.book, color: Colors.tealAccent),
            "education"),
        ReceiptCategory(
            S.of(context).diySupermarkt,
            Icon(Icons.handyman,
                color:Colors.teal),
            "craft"),
      ];
    }

    categories.sort((a, b) => a.name.compareTo(b.name));
    return categories;
  }
}
