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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipt_manager/database/receipt_database.dart';
import 'package:receipt_manager/factory/button_factory.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

class TextFormFactory {
  static TextFormField date(TextEditingController dateController,
      DateTime receiptDate, BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey)),
          hintText: S.of(context).receiptDateFormat,
          labelText: S.of(context).receiptDateLabelText,
          helperText: S.of(context).receiptDateHelperText,
          prefixIcon: ButtonFactory.buildDateButton(
              receiptDate, dateController, context)),
      controller: dateController,
      validator: (value) {
        if (value.isEmpty) {
          return S.of(context).receiptEmpty;
        }
        RegExp totalRegex = new RegExp(
            "^(0?[1-9]|[12][0-9]|3[01])[.\\/ ]?(0?[1-9]|1[0-2])[./ ]?(?:19|20)[0-9]{2}\$",
            caseSensitive: false,
            multiLine: false);

        if (!totalRegex.hasMatch(value.trim())) {
          return S.of(context).receiptDateInvalid +
              " " +
              S.of(context).receiptDateFormat;
        }

        return null;
      },
    );
  }

  static TextFormField total(
      TextEditingController receiptTotalController, BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey)),
        hintText: S.of(context).totalTitle,
        labelText: S.of(context).totalLabelText,
        helperText: S.of(context).totalHelperText,
        prefixIcon: const Icon(
          Icons.attach_money,
        ),
        prefixText: ' ',
      ),
      controller: receiptTotalController,
      validator: (value) {
        if (value.isEmpty) {
          return S.of(context).emptyTotal;
        }
        RegExp totalRegex = new RegExp("^(?=.*[1-9])[0-9]*[.]?[0-9]{2}\$",
            caseSensitive: false, multiLine: false);

        if (!totalRegex.hasMatch(value)) {
          return S.of(context).invalidTotal;
        }

        return null;
      },
    );
  }

  static SimpleAutocompleteFormField storeName(
      TextEditingController storeNameController,
      BuildContext context,
      List<Receipt> receipt) {
    List<String> storeNameList = [];
    if (receipt != null) {
      for (Receipt r in receipt) {
        if (!storeNameList.contains(r.shop)) storeNameList.add(r.shop);
      }
    }

    return SimpleAutocompleteFormField<String>(
      style: TextStyle(color: Colors.black),
      decoration: new InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.black)),
        hintText: S.of(context).storeNameHint,
        labelText: S.of(context).storeNameTitle,
        helperText: S.of(context).storeNameHelper,
        prefixIcon: const Icon(Icons.storefront_outlined),
        prefixText: ' ',
      ),
      maxSuggestions: 5,
      itemBuilder: (context, _storeName) => Padding(
        padding: EdgeInsets.only(top: 16, left: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(_storeName, style: TextStyle(color: Colors.black, fontSize: 16)),
        ]),
      ),
      onSearch: (search) async => storeNameList
          .where((_storeName) =>
              _storeName.toLowerCase().contains(search.toLowerCase()))
          .toList(),
      controller: storeNameController,
      itemFromString: (string) => storeNameList.singleWhere(
          (_storeName) => _storeName.toLowerCase() == string.toLowerCase(),
          orElse: () => null),
      validator: (value) {
        if (value.isEmpty) {
          return S.of(context).emptyStoreName;
        }
        return null;
      },
    );
  }
}
