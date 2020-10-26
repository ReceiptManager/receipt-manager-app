/*
 * Copyright (c) 2020 - William Todt
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/model/receipt_category.dart';

/// {@category Factory}
/// {@subCategory Information displays}
/// {@image <image alt='' src='/images/catalog-widget-placeholder.png'>}
class ReceiptCategoryFactory {
  // initialise category only once
  static List<ReceiptCategory> categories;

  static List<ReceiptCategory> get(BuildContext context) {
    if (categories == null) {
      categories = <ReceiptCategory>[
        ReceiptCategory(S.of(context).groceryCategory,
            Icon(Icons.shopping_bag_outlined), "grocery"),
        ReceiptCategory(S.of(context).healthCategory,
            Icon(Icons.medical_services), "health"),
      ];
    }

    return categories;
  }
}
