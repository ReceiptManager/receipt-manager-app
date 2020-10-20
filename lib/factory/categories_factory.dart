import 'package:flutter/material.dart';
import 'package:receipt_parser/generated/l10n.dart';
import 'package:receipt_parser/model/receipt_category.dart';

class ReceiptCategoryFactory {
  static List<ReceiptCategory> categories;

  static List<ReceiptCategory> get(BuildContext context) {
    if (categories == null) {
      categories = <ReceiptCategory>[
        ReceiptCategory(
            S.of(context).groceryCategory, Icon(Icons.shopping_bag_outlined)),
        ReceiptCategory(
            S.of(context).healthCategory, Icon(Icons.medical_services)),
      ];
    }

    return categories;
  }
}
