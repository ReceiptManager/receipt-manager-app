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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:receipt_manager/db/receipt_database.dart';
import 'package:receipt_manager/factory/button_factory.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

enum FORM_MODES { DATE, TOTAL, ITEM_NAME, ITEM_TOTAL, STORE_NAME, TAG }

class TextFormFactory {
  static TextFormField date(TextEditingController dateController,
      DateTime receiptDate, BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      decoration: new InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[100]),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey[100])),
          hintText: S.of(context).receiptDateFormat,
          //labelText: S.of(context).receiptDateLabelText,
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
      decoration: new InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[100]),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey[100])),
        hintText: S.of(context).totalTitle,
        // labelText: S.of(context).totalLabelText,
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

  static TextFormField tag(
      TextEditingController receiptTagController, BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      decoration: new InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[100]),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey[100])),
        hintText: S.of(context).totalTitle,
        helperText: S.of(context).totalHelperText,
        prefixIcon: const Icon(
          Icons.tag,
        ),
        prefixText: ' ',
      ),
      controller: receiptTagController,
      validator: (value) {
        return null;
      },
    );
  }

  static TextFormField itemName(
      TextEditingController receiptTotalController, BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      decoration: new InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[100]),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey[100])),
        hintText: S.of(context).itemTitle,
        //labelText: S.of(context).itemLabelText,
        helperText: S.of(context).itemHelperText,
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

  static TextFormField itemTotal(
      TextEditingController receiptTotalController, BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      decoration: new InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[100]),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey[100])),
        hintText: S.of(context).itemTotalTitle,
        //labelText: S.of(context).itemTotalLabelText,
        helperText: S.of(context).itemTotalHelperText,
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

    for (Receipt r in receipt)
      if (!storeNameList.contains(r.shop.trim()))
        storeNameList.add(r.shop.trim());

    return SimpleAutocompleteFormField<String>(
      style: TextStyle(color: Colors.black),
      decoration: new InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[100]),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey[100])),
        hintText: S.of(context).storeNameHint,
        //labelText: S.of(context).storeNameTitle,
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
    );
  }

  static dateTextField(DateTime _receiptDate,
      TextEditingController _dateController, BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      decoration: new InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[100]),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey[100])),
          hintText: S.of(context).receiptDateFormat,
          // labelText:
          //   S.of(context).receiptDateLabelText,
          helperText: S.of(context).receiptDateHelperText,
          prefixIcon: IconButton(
              icon: Icon(
                Icons.calendar_today,
                color: Colors.red[350],
              ),
              splashColor: Colors.black,
              color: Colors.black,
              onPressed: () async {
                _receiptDate = await showDatePicker(
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: Colors.black,
                          accentColor: Colors.black,
                          colorScheme: ColorScheme.light(primary: (Colors.red)),
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                        ),
                        child: child,
                      );
                    },
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2050));

                if (_receiptDate == null)
                  _dateController.text = "";
                else
                  _dateController.text =
                      DateFormat(S.of(context).receiptDateFormat)
                          .format(_receiptDate);
              })),
      controller: _dateController,
      validator: (value) {
        if (value.isEmpty) {
          return S.of(context).receiptDateDialog;
        }

        try {
          var format = DateFormat(S.of(context).receiptDateFormat);
          _receiptDate = format.parse(value);
          return null;
        } catch (_) {
          _receiptDate = null;
          return S.of(context).receiptDateNotFormatted +
              " " +
              S.of(context).receiptDateFormat;
        }
      },
    );
  }
}
