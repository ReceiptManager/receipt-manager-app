// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null, 'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;
 
      return instance;
    });
  } 

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null, 'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Add Receipt`
  String get addReceipt {
    return Intl.message(
      'Add Receipt',
      name: 'addReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Input is invalid`
  String get invalidInput {
    return Intl.message(
      'Input is invalid',
      name: 'invalidInput',
      desc: '',
      args: [],
    );
  }

  /// `Receipt store name is empty`
  String get emptyStoreName {
    return Intl.message(
      'Receipt store name is empty',
      name: 'emptyStoreName',
      desc: '',
      args: [],
    );
  }

  /// `Failed to upload image`
  String get failedUploadImage {
    return Intl.message(
      'Failed to upload image',
      name: 'failedUploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Receipt category is empty`
  String get emptyCategory {
    return Intl.message(
      'Receipt category is empty',
      name: 'emptyCategory',
      desc: '',
      args: [],
    );
  }

  /// `Receipt date is empty`
  String get emptyReceiptDate {
    return Intl.message(
      'Receipt date is empty',
      name: 'emptyReceiptDate',
      desc: '',
      args: [],
    );
  }

  /// `Receipt total is empty`
  String get emptyTotal {
    return Intl.message(
      'Receipt total is empty',
      name: 'emptyTotal',
      desc: '',
      args: [],
    );
  }

  /// `Receipt Overview`
  String get receiptOverview {
    return Intl.message(
      'Receipt Overview',
      name: 'receiptOverview',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `No receipts inserted.`
  String get noReceiptsInserted {
    return Intl.message(
      'No receipts inserted.',
      name: 'noReceiptsInserted',
      desc: '',
      args: [],
    );
  }

  /// `Server settings`
  String get serverSettings {
    return Intl.message(
      'Server settings',
      name: 'serverSettings',
      desc: '',
      args: [],
    );
  }

  /// `API Token`
  String get apiToken {
    return Intl.message(
      'API Token',
      name: 'apiToken',
      desc: '',
      args: [],
    );
  }

  /// `Network settings`
  String get networkSettings {
    return Intl.message(
      'Network settings',
      name: 'networkSettings',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Camera settings`
  String get cameraSettings {
    return Intl.message(
      'Camera settings',
      name: 'cameraSettings',
      desc: '',
      args: [],
    );
  }

  /// `Rotate Image`
  String get rotateImage {
    return Intl.message(
      'Rotate Image',
      name: 'rotateImage',
      desc: '',
      args: [],
    );
  }

  /// `Grayscale Image`
  String get grayscaleImage {
    return Intl.message(
      'Grayscale Image',
      name: 'grayscaleImage',
      desc: '',
      args: [],
    );
  }

  /// `Gaussian Blur`
  String get gaussianBlur {
    return Intl.message(
      'Gaussian Blur',
      name: 'gaussianBlur',
      desc: '',
      args: [],
    );
  }

  /// `Developer settings`
  String get developerSettings {
    return Intl.message(
      'Developer settings',
      name: 'developerSettings',
      desc: '',
      args: [],
    );
  }

  /// `Enable Debug Output`
  String get enableDebugOutput {
    return Intl.message(
      'Enable Debug Output',
      name: 'enableDebugOutput',
      desc: '',
      args: [],
    );
  }

  /// `Show Articles`
  String get showArticles {
    return Intl.message(
      'Show Articles',
      name: 'showArticles',
      desc: '',
      args: [],
    );
  }

  /// `Analytics`
  String get analytics {
    return Intl.message(
      'Analytics',
      name: 'analytics',
      desc: '',
      args: [],
    );
  }

  /// `Category overview`
  String get categoryOverview {
    return Intl.message(
      'Category overview',
      name: 'categoryOverview',
      desc: '',
      args: [],
    );
  }

  /// `Expenses overview`
  String get expensesOverview {
    return Intl.message(
      'Expenses overview',
      name: 'expensesOverview',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Total`
  String get monthlyTotal {
    return Intl.message(
      'Monthly Total',
      name: 'monthlyTotal',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Weekly total`
  String get weeklyTotal {
    return Intl.message(
      'Weekly total',
      name: 'weeklyTotal',
      desc: '',
      args: [],
    );
  }

  /// `Weekly overview`
  String get weeklyOverview {
    return Intl.message(
      'Weekly overview',
      name: 'weeklyOverview',
      desc: '',
      args: [],
    );
  }

  /// `Annual overview`
  String get annualOverview {
    return Intl.message(
      'Annual overview',
      name: 'annualOverview',
      desc: '',
      args: [],
    );
  }

  /// `Show Image`
  String get showImage {
    return Intl.message(
      'Show Image',
      name: 'showImage',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message(
      'Upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `Receipt Category`
  String get receiptCategory {
    return Intl.message(
      'Receipt Category',
      name: 'receiptCategory',
      desc: '',
      args: [],
    );
  }

  /// `The receipt category`
  String get theReceiptCategory {
    return Intl.message(
      'The receipt category',
      name: 'theReceiptCategory',
      desc: '',
      args: [],
    );
  }

  /// `Store Name`
  String get storeName {
    return Intl.message(
      'Store Name',
      name: 'storeName',
      desc: '',
      args: [],
    );
  }

  /// `The receipt store name`
  String get theReceiptStoreName {
    return Intl.message(
      'The receipt store name',
      name: 'theReceiptStoreName',
      desc: '',
      args: [],
    );
  }

  /// `Receipt Tag`
  String get receiptTag {
    return Intl.message(
      'Receipt Tag',
      name: 'receiptTag',
      desc: '',
      args: [],
    );
  }

  /// `The receipt tag`
  String get theReceiptTag {
    return Intl.message(
      'The receipt tag',
      name: 'theReceiptTag',
      desc: '',
      args: [],
    );
  }

  /// `Receipt Total`
  String get receiptTotal {
    return Intl.message(
      'Receipt Total',
      name: 'receiptTotal',
      desc: '',
      args: [],
    );
  }

  /// `The receipt total`
  String get theReceiptTotal {
    return Intl.message(
      'The receipt total',
      name: 'theReceiptTotal',
      desc: '',
      args: [],
    );
  }

  /// `Receipt Date`
  String get receiptDate {
    return Intl.message(
      'Receipt Date',
      name: 'receiptDate',
      desc: '',
      args: [],
    );
  }

  /// `The receipt date`
  String get theReceiptDate {
    return Intl.message(
      'The receipt date',
      name: 'theReceiptDate',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}