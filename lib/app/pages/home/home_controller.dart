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

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:intl/intl.dart';
import 'package:receipt_manager/app/pages/home/home_presenter.dart';
import 'package:receipt_manager/data/repository/receipt_repository.dart';

// TODO: implement settings controller
class HomeController extends Controller {
  final HomePresenter _homePresenter;

  TextEditingController _storeNameController = TextEditingController();
  TextEditingController _receiptDateController = TextEditingController();
  TextEditingController _receiptTotalController = TextEditingController();
  TextEditingController _receiptTagController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  HomeController(ReceiptRepository receiptRepository)
      : _homePresenter = HomePresenter(receiptRepository),
        super();

  @override
  void initListeners() {}

  TextEditingController get storeNameController => _storeNameController;

  TextEditingController get receiptDateController => _receiptDateController;

  TextEditingController get receiptTotalController => _receiptTotalController;

  TextEditingController get receiptTagController => _receiptTagController;

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

  void submit() {
    if (!_formKey.currentState.validate()) fail();

    String storeName = _storeNameController.text;
    String total = _receiptTotalController.text;
    String date = _receiptDateController.text;
    String tag = _receiptTagController.text;

    success();
  }

  String validateStoreName(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Receipt store name is empty";
    }

    return null;
  }

  String validateTotal(String value) {
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

  String validateDate(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Receipt date is empty";
    }

    RegExp totalRegex = new RegExp(
        "^(0?[1-9]|[12][0-9]|3[01])[.\\/ ]?(0?[1-9]|1[0-2])[./ ]?(?:19|20)[0-9]{2}\$",
        caseSensitive: false,
        multiLine: false);

    if (!totalRegex.hasMatch(value)) {
      return "Invalid receipt format";
    }

    DateTime _receiptDate;
    try {
      var format = DateFormat("dd.MM.y");
      _receiptDate = format.parse(value);

      if (!(_receiptDate.year < 100)) {
        return null;
      }
    } catch (_) {
      log(_.toString());
    }

    return "Invalid receipt format";
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