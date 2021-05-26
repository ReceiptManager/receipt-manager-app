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

import 'dart:convert';
import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:currency_picker/currency_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:receipt_manager/app/helper/notfifier.dart';
import 'package:receipt_manager/app/helper/receipt_logger.dart';
import 'package:receipt_manager/app/pages/home/home_presenter.dart';
import 'package:receipt_manager/app/pages/upload/file_upload_view.dart';
import 'package:receipt_manager/app/pages/upload/image_upload_view.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';
import 'package:receipt_manager/data/storage/receipt_database.dart';
import 'package:receipt_manager/data/storage/scheme/insert_holder_table.dart';
import 'package:receipt_manager/generated/l10n.dart';

class HomeController extends Controller {
  final HomePresenter _homePresenter;

  TextEditingController _storeNameController = TextEditingController();
  TextEditingController _receiptDateController = TextEditingController();
  TextEditingController _receiptTotalController = TextEditingController();
  TextEditingController _receiptTagController = TextEditingController();
  TextEditingController _receiptCategoryController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  Currency? currency;
  DateTime? _receiptDate;
  DataReceiptRepository appRepository;

  HomeController(DataReceiptRepository appRepository)
      : _homePresenter = HomePresenter(),
        this.appRepository = DataReceiptRepository(),
        super();

  Future<void> getImageResult(File image) async {
    await FlutterUploader().cancelAll();
    await FlutterUploader().clearUploads();

    Navigator.of(getContext()).push(MaterialPageRoute(
        builder: (BuildContext context) => ImageUploadPage(image)));

    bool updated = false;
    FlutterUploader().result.listen((result) {
      if (result.statusCode == 200 && result.response != null && !updated) {
        Map<String, dynamic> r = jsonDecode(result.response!);

        _storeNameController.text = r['storeName'] ?? "";
        _receiptTotalController.text = r['receiptTotal'] ?? "";
        if (r['receiptTotal'] != null) {}

        UserNotifier.msg(S.of(getContext()).receiptIsReady,
            S.of(getContext()).receiptSuccessfullyAnalyzed, getContext());
        updated = true;
      }
    }, onError: (ex, stacktrace) {
      UserNotifier.fail(
          S.of(getContext()).failedUploadImage, this.getContext());
    });
  }

  Future<void> galleryPicker() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      getImageResult(image);
    }
  }

  Future<void> cameraPicker() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      await GallerySaver.saveImage(image.path, albumName: "ReceiptManager");

      getImageResult(image);
    }
  }

  Future<void> filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.single;
      getFileResult(file);
    } else {}
  }

  Future<List<String>> getStoreNames(String pattern) async {
    List<Store> list = await this.appRepository.getStoreNames();
    List<String> storeNames = [];
    for (var store in list) {
      if (!storeNames.contains(store.storeName))
        storeNames.add(store.storeName);
    }
    return storeNames
        .where((element) =>
            element.toUpperCase().startsWith(pattern.toUpperCase()))
        .toList();
  }

  Future<List<String>> getTagNames(String pattern) async {
    List<Tag> list = await this.appRepository.getTagNames();
    List<String> tagNames = [];
    for (var tag in list) {
      if (!tagNames.contains(tag.tagName) && tag.tagName.isNotEmpty)
        tagNames.add(tag.tagName);
    }
    return tagNames
        .where((element) =>
            element.toUpperCase().startsWith(pattern.toUpperCase()))
        .toList();
  }

  Future<List<String>> getCategoryNames(String pattern) async {
    List<Categorie> list = await this.appRepository.getCategoryNames();
    List<String> categoryNames = [];
    for (var category in list) {
      if (!categoryNames.contains(category.categoryName))
        categoryNames.add(category.categoryName);
    }
    return categoryNames
        .where((element) =>
            element.toUpperCase().startsWith(pattern.toUpperCase()))
        .toList();
  }

  String? validateCategory(value) {
    value = value.trim();
    if (value.isEmpty) {
      return S.of(getContext()).emptyCategory;
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
  void initListeners() {
  }

  TextEditingController get storeNameController => _storeNameController;

  TextEditingController get receiptDateController => _receiptDateController;

  TextEditingController get receiptTotalController => _receiptTotalController;

  TextEditingController get receiptTagController => _receiptTagController;

  TextEditingController get receiptCategoryController =>
      _receiptCategoryController;

  get formKey => _formKey;

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) {
      UserNotifier.fail(S.of(getContext()).invalidInput, getContext());
      refreshUI();
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
      date: Value(_receiptDate!),
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

    UserNotifier.success(S.of(getContext()).addedSuccessfully, getContext());
    refreshUI();
  }

  String? validateStoreName(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return S.of(getContext()).emptyStoreName;
    }

    return null;
  }

  String? validateTotal(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return S.of(getContext()).emptyTotal;
    }

    try {
      double.parse(value);
    } catch (_) {}
    return null;
  }

  String? validateDate(String value) {
    value = value.trim();
    if (value.isEmpty || this._receiptDate == null) {
      return S.of(getContext()).emptyReceiptDate;
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

  sendTestNotification() {

  }

  Future<void> getFileResult(PlatformFile file) async {
    Map results = await Navigator.of(this.getContext())
        .push(new MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        return new FileUploadPage(file);
      },
    ));

    if (results.containsKey('receipt')) {
      InsertReceiptHolder holder = results['receipt'];

      _storeNameController.text = holder.store.storeName.value;
      _receiptTotalController.text =
          holder.receipt.total.value.toStringAsFixed(2);
      _receiptDateController.text =
          DateFormat.yMMMd().format(holder.receipt.date.value);

      print(results['receipt']);
    }
  }
}
