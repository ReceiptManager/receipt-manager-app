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
import 'package:intl/intl.dart';
import 'package:receipt_manager/app/helper/receipt_logger.dart';
import 'package:receipt_manager/app/pages/home/home_presenter.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';
import 'package:receipt_manager/data/storage/receipt_database.dart';
import 'package:receipt_manager/data/storage/scheme/insert_holder_table.dart';

// TODO: implement settings controller
class HomeController extends Controller {
  final HomePresenter _homePresenter;

  TextEditingController _storeNameController = TextEditingController();
  TextEditingController _receiptDateController = TextEditingController();
  TextEditingController _receiptTotalController = TextEditingController();
  TextEditingController _receiptTagController = TextEditingController();
  TextEditingController _receiptCategoryController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Currency? currency;
  DateTime? _receiptDate;
  var receiptsBox;

  DataReceiptRepository appRepository;

  HomeController(DataReceiptRepository appRepository)
      : _homePresenter = HomePresenter(),
        this.appRepository = DataReceiptRepository(),
        super();

  Future<List<String>> getStoreNames() async {
    List<Store> list = await this.appRepository.getStoreNames();
    List<String> storeNames = [];
    for (var store in list) {
      if (!storeNames.contains(store.storeName))
        storeNames.add(store.storeName);
    }
    return storeNames;
  }

  Future<List<String>> getTagNames() async {
    List<Tag> list = await this.appRepository.getTagNames();
    List<String> tagNames = [];
    for (var tag in list) {
      if (!tagNames.contains(tag.tagName) && tag.tagName.isNotEmpty)
        tagNames.add(tag.tagName);
    }
    return tagNames;
  }

  Future<List<String>> getCategoryNames() async {
    List<Categorie> list = await this.appRepository.getCategoryNames();
    List<String> categoryNames = [];
    for (var category in list) {
      if (!categoryNames.contains(category.categoryName))
        categoryNames.add(category.categoryName);
    }
    return categoryNames;
  }

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

    if (picked != null) {
      _receiptDate = picked;
      _receiptDateController.text = DateFormat.yMMMd().format(picked);
    }
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

  Future<void> debugInsert() async {
    StoresCompanion store = StoresCompanion(storeName: Value("StoreTest"));
    TagsCompanion tag = TagsCompanion(tagName: Value("TagTest"));
    CategoriesCompanion categoriesCompanion =
        CategoriesCompanion(categoryName: Value("Category"));
    ReceiptsCompanion receipt = ReceiptsCompanion(
      date: Value(DateTime.now()),
      total: Value(19.00),
      currency: Value("\$"),
    );

    InsertReceiptHolder receiptHolder = InsertReceiptHolder(
        tag: tag,
        store: store,
        category: categoriesCompanion,
        receipt: receipt);

    await appRepository.insertReceipt(receiptHolder);
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
    String _categoryString = _receiptCategoryController.text.trim();

    ReceiptLogger.logger(
        _storeNameString, _totalString, _dateString, _tagString);

    StoresCompanion store = StoresCompanion(storeName: Value(_storeNameString));

    TagsCompanion tag = TagsCompanion(tagName: Value(_tagString));

    CategoriesCompanion categoriesCompanion =
        CategoriesCompanion(categoryName: Value(_categoryString));

    ReceiptsCompanion receipt = ReceiptsCompanion(
      date: Value(DateTime.now()),
      total: Value(double.parse(_totalString)),
      currency: Value(currency?.symbol ?? "€"),
    );

    InsertReceiptHolder receiptHolder = InsertReceiptHolder(
        tag: tag,
        store: store,
        category: categoriesCompanion,
        receipt: receipt);

    await appRepository.insertReceipt(receiptHolder);

    _storeNameController.clear();
    _receiptTotalController.clear();
    _receiptDateController.clear();
    _receiptTagController.clear();
    _receiptCategoryController.clear();
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

    try {
      double.parse(value);
    } catch (_) {
      log(_.toString());
    }
    return null;
  }

  String? validateDate(String value) {
    value = value.trim();
    if (value.isEmpty || this._receiptDate == null) {
      return "Receipt date is empty";
    }

    return null;
  }

  void currencyPicker(BuildContext context) {
    showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        this.currency = currency;
        refreshUI();
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
