/*
 *  Copyright (c) 2020 - William Todt
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/model/receipt_category.dart';

/// {@category Factory}
/// {@subCategory Information displays}
/// {@image <image alt='' src='/images/catalog-widget-placeholder.png'>}
class ReceiptCategoryFactory {
  // initialise category only once
  static List<ReceiptCategory> categories;
  static RandomColor _rand = RandomColor();

  static List<ReceiptCategory> get(BuildContext context) {
    if (categories == null) {
      categories = <ReceiptCategory>[
        ReceiptCategory(
            S.of(context).groceryCategory,
            Icon(Icons.shopping_bag_outlined,
                color: _rand.randomColor(colorHue: ColorHue.red)),
            "grocery"),
        ReceiptCategory(
            S.of(context).healthCategory,
            Icon(Icons.medical_services,
                color: _rand.randomColor(colorHue: ColorHue.blue)),
            "health"),
        ReceiptCategory(
            S.of(context).Rent,
            Icon(Icons.store_mall_directory,
                color: _rand.randomColor(colorHue: ColorHue.orange)),
            "rent"),
        ReceiptCategory(
            S.of(context).food,
            Icon(Icons.shop,
                color: _rand.randomColor(colorHue: ColorHue.yellow)),
            "food"),
        ReceiptCategory(
            S.of(context).entertainment,
            Icon(Icons.fastfood_sharp,
                color: _rand.randomColor(colorHue: ColorHue.green)),
            "entertainment"),
        ReceiptCategory(
            S.of(context).employeeBenefits,
            Icon(Icons.people,
                color: _rand.randomColor(colorHue: ColorHue.orange)),
            "employees"),
        ReceiptCategory(
            S.of(context).util,
            Icon(Icons.edit_location_outlined,
                color: _rand.randomColor(colorHue: ColorHue.red)),
            "util"),
        ReceiptCategory(
            S.of(context).travel,
            Icon(Icons.edit,
                color: _rand.randomColor(colorHue: ColorHue.purple)),
            "globe"),
        ReceiptCategory(
            S.of(context).education,
            Icon(Icons.book, color: _rand.randomColor(colorHue: ColorHue.blue)),
            "education"),
        ReceiptCategory(
            S.of(context).diySupermarkt,
            Icon(Icons.book, color: _rand.randomColor(colorHue: ColorHue.blue)),
            "craft"),
      ];
    }

    categories.sort((a, b) => a.name.compareTo(b.name));
    return categories;
  }
}
