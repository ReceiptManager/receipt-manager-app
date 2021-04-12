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

import 'dart:developer';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:receipt_manager/app/helper/receipt_logger.dart';
import 'package:receipt_manager/app/pages/home/home_presenter.dart';
import 'package:receipt_manager/data/repository/app_repository.dart';

// TODO: implement settings controller
class HomeController extends Controller {
  final HomePresenter _homePresenter;

  TextEditingController _storeNameController = TextEditingController();
  TextEditingController _receiptDateController = TextEditingController();
  TextEditingController _receiptTotalController = TextEditingController();
  TextEditingController _receiptTagController = TextEditingController();
  TextEditingController _receiptCategoryController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var receiptsBox;

  HomeController(AppRepository appRepository)
      : _homePresenter = HomePresenter(),
        receiptsBox = Hive.box('receipts'),
        super();

  String? validateCategory(value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Receipt category is empty";
    }

    return null;
  }

  void setDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
    );

    _receiptDateController.text = DateFormat.yMMMd().format(picked!);
  }

  @override
  void initListeners() {}

  TextEditingController get storeNameController => _storeNameController;

  TextEditingController get receiptDateController => _receiptDateController;

  TextEditingController get receiptTotalController => _receiptTotalController;

  TextEditingController get receiptTagController => _receiptTagController;

  TextEditingController get receiptCategoryController =>
      _receiptCategoryController;

  get formKey => _formKey;

  void fail() {
    print('Receipt is invalid.');
    ScaffoldMessenger.of(getContext()).showSnackBar(SnackBar(
      content: Text("Receipt is invalid"),
      backgroundColor: Colors.red,
    ));

    refreshUI();
  }

  void success() {
    print('Receipt is valid.');
    ScaffoldMessenger.of(getContext()).showSnackBar(SnackBar(
      content: Text("Receipt is valid"),
      backgroundColor: Colors.green,
    ));

    refreshUI();
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) {
      fail();
      return;
    }

    String _storeNameString = _storeNameController.text.trim();
    String _totalString = _receiptTotalController.text.trim();
    String _dateString = _receiptDateController.text.trim();
    String _tagString = _receiptTagController.text.trim();

    ReceiptLogger.logger(
        _storeNameString, _totalString, _dateString, _tagString);

    success();
  }

  String? validateStoreName(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Receipt store name is empty";
    }

    return null;
  }

  String? validateTotal(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Receipt total is empty";
    }
    RegExp totalRegex = new RegExp("^(?=.*[1-9])[0-9]*[.|,]?[0-9]{2}\$",
        caseSensitive: false, multiLine: false);

    if (!totalRegex.hasMatch(value)) {
      return "Receipt total is invalid";
    }

    return null;
  }

  String? validateDate(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Receipt date is empty";
    }

    DateTime _receiptDate;
    try {
      var format = DateFormat("dd-MM-y");
      _receiptDate = format.parse(value);

      if (!(_receiptDate.year < 100)) {
        return null;
      }
    } catch (_) {
      log(_.toString());
    }

    return "Invalid receipt format";
  }

  void currencyPicker(BuildContext context) {
    showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        print('Select currency: ${currency.name}');
      },
    );
  }

  @override
  void onResumed() => print('On resumed');

  @override
  void onReassembled() => print('View is about to be reassembled');

  @override
  void onDeactivated() => print('View is about to be deactivated');

  @override
  void onDisposed() {
    _homePresenter.dispose();
    super.onDisposed();
  }
}
