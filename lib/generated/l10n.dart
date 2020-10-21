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

  static S current;

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();

      return S.current;
    });
  }

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Mein Haushaltsbuch`
  String get appBarTitle {
    return Intl.message(
      'Mein Haushaltsbuch',
      name: 'appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Allgemein`
  String get settingsGeneralCategory {
    return Intl.message(
      'Allgemein',
      name: 'settingsGeneralCategory',
      desc: '',
      args: [],
    );
  }

  /// `Sprache`
  String get settingsLanguageTitle {
    return Intl.message(
      'Sprache',
      name: 'settingsLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Deutsch`
  String get currentLanguage {
    return Intl.message(
      'Deutsch',
      name: 'currentLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Entwickler`
  String get settingsDeveloperTitle {
    return Intl.message(
      'Entwickler',
      name: 'settingsDeveloperTitle',
      desc: '',
      args: [],
    );
  }

  /// `Entwickelerwerkzeuge`
  String get settingsDeveloperSubtitle {
    return Intl.message(
      'Entwickelerwerkzeuge',
      name: 'settingsDeveloperSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Netzwerk`
  String get settingsNetworkCategory {
    return Intl.message(
      'Netzwerk',
      name: 'settingsNetworkCategory',
      desc: '',
      args: [],
    );
  }

  /// `Netzwerk Einstellungen`
  String get settingsServerTitle {
    return Intl.message(
      'Netzwerk Einstellungen',
      name: 'settingsServerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Entwicklung`
  String get settingsDevelopmentTitle {
    return Intl.message(
      'Entwicklung',
      name: 'settingsDevelopmentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Entwicklerinformationen anzeigen`
  String get enableDebugOutput {
    return Intl.message(
      'Entwicklerinformationen anzeigen',
      name: 'enableDebugOutput',
      desc: '',
      args: [],
    );
  }

  /// `Verschiedenes`
  String get settingsMiscTitle {
    return Intl.message(
      'Verschiedenes',
      name: 'settingsMiscTitle',
      desc: '',
      args: [],
    );
  }

  /// `Open-Source Lizenzen`
  String get openSourceLicence {
    return Intl.message(
      'Open-Source Lizenzen',
      name: 'openSourceLicence',
      desc: '',
      args: [],
    );
  }

  /// `Kassenbeleg hinzufügen`
  String get addReceipt {
    return Intl.message(
      'Kassenbeleg hinzufügen',
      name: 'addReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Bitte geben Sie ein Datum ein`
  String get receiptEmpty {
    return Intl.message(
      'Bitte geben Sie ein Datum ein',
      name: 'receiptEmpty',
      desc: '',
      args: [],
    );
  }

  /// `dd.MM.y`
  String get receiptDateFormat {
    return Intl.message(
      'dd.MM.y',
      name: 'receiptDateFormat',
      desc: '',
      args: [],
    );
  }

  /// `Datum`
  String get receiptDateLabelText {
    return Intl.message(
      'Datum',
      name: 'receiptDateLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Receipt date is invalid, format:`
  String get receiptDateInvalid {
    return Intl.message(
      'Receipt date is invalid, format:',
      name: 'receiptDateInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Füge das Datum das Kassenbeleg hinzu`
  String get receiptDateHelperText {
    return Intl.message(
      'Füge das Datum das Kassenbeleg hinzu',
      name: 'receiptDateHelperText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter some date`
  String get receiptDateDialog {
    return Intl.message(
      'Please enter some date',
      name: 'receiptDateDialog',
      desc: '',
      args: [],
    );
  }

  /// `Eingabeformat ungültig`
  String get receiptDateNotFormatted {
    return Intl.message(
      'Eingabeformat ungültig',
      name: 'receiptDateNotFormatted',
      desc: '',
      args: [],
    );
  }

  /// `Wähle eine Kategorie`
  String get receiptSelectCategory {
    return Intl.message(
      'Wähle eine Kategorie',
      name: 'receiptSelectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Eingabe is ungültig`
  String get invalidInput {
    return Intl.message(
      'Eingabe is ungültig',
      name: 'invalidInput',
      desc: '',
      args: [],
    );
  }

  /// `Bild konnte nicht hochgeladen werden`
  String get uploadFailed {
    return Intl.message(
      'Bild konnte nicht hochgeladen werden',
      name: 'uploadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Bild erfolgreich hochgeladen`
  String get uploadSuccess {
    return Intl.message(
      'Bild erfolgreich hochgeladen',
      name: 'uploadSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Ein Fehler ist aufgetreten, Kassenbelege konnten nicht geladen werden`
  String get receiptLoadFailed {
    return Intl.message(
      'Ein Fehler ist aufgetreten, Kassenbelege konnten nicht geladen werden',
      name: 'receiptLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Löschen`
  String get deleteReceipt {
    return Intl.message(
      'Löschen',
      name: 'deleteReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Editieren`
  String get editReceipt {
    return Intl.message(
      'Editieren',
      name: 'editReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Kassenbeleg aktualisieren`
  String get updateReceipt {
    return Intl.message(
      'Kassenbeleg aktualisieren',
      name: 'updateReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Beleg erfolgreich aktualisiert`
  String get updateReceiptSuccessful {
    return Intl.message(
      'Beleg erfolgreich aktualisiert',
      name: 'updateReceiptSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Beleg wurde nicht aktualisiert`
  String get failedUpdateReceipt {
    return Intl.message(
      'Beleg wurde nicht aktualisiert',
      name: 'failedUpdateReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Abbrechen`
  String get cancel {
    return Intl.message(
      'Abbrechen',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Aktualisieren`
  String get update {
    return Intl.message(
      'Aktualisieren',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Server ip`
  String get serverIP {
    return Intl.message(
      'Server ip',
      name: 'serverIP',
      desc: '',
      args: [],
    );
  }

  /// `Server ip Addresse`
  String get serverIPLabelText {
    return Intl.message(
      'Server ip Addresse',
      name: 'serverIPLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Zugangs-Server Addresse `
  String get serverIPHelpText {
    return Intl.message(
      'Zugangs-Server Addresse ',
      name: 'serverIPHelpText',
      desc: '',
      args: [],
    );
  }

  /// `Server Einstellungen`
  String get serverSettings {
    return Intl.message(
      'Server Einstellungen',
      name: 'serverSettings',
      desc: '',
      args: [],
    );
  }

  /// `Die eingegebene IP war falsch. Bitte versuchen Sie es erneut`
  String get invalidServerIP {
    return Intl.message(
      'Die eingegebene IP war falsch. Bitte versuchen Sie es erneut',
      name: 'invalidServerIP',
      desc: '',
      args: [],
    );
  }

  /// `Zugangs-Server Addresse aktualisiert.`
  String get updateServerIP {
    return Intl.message(
      'Zugangs-Server Addresse aktualisiert.',
      name: 'updateServerIP',
      desc: '',
      args: [],
    );
  }

  /// `Lebensmittel`
  String get groceryCategory {
    return Intl.message(
      'Lebensmittel',
      name: 'groceryCategory',
      desc: '',
      args: [],
    );
  }

  /// `Gesundheit`
  String get healthCategory {
    return Intl.message(
      'Gesundheit',
      name: 'healthCategory',
      desc: '',
      args: [],
    );
  }

  /// `Shop Name`
  String get storeNameTitle {
    return Intl.message(
      'Shop Name',
      name: 'storeNameTitle',
      desc: '',
      args: [],
    );
  }

  /// `Shop Name`
  String get storeNameHint {
    return Intl.message(
      'Shop Name',
      name: 'storeNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Füge einen Shop Namen hinzu`
  String get storeNameHelper {
    return Intl.message(
      'Füge einen Shop Namen hinzu',
      name: 'storeNameHelper',
      desc: '',
      args: [],
    );
  }

  /// `'Bitte gebe einen Shop Namen an.`
  String get emptyStoreName {
    return Intl.message(
      '\'Bitte gebe einen Shop Namen an.',
      name: 'emptyStoreName',
      desc: '',
      args: [],
    );
  }

  /// `Betrag`
  String get totalTitle {
    return Intl.message(
      'Betrag',
      name: 'totalTitle',
      desc: '',
      args: [],
    );
  }

  /// `Betrag`
  String get totalLabelText {
    return Intl.message(
      'Betrag',
      name: 'totalLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Füge den Betrag des Beleges hinzu`
  String get totalHelperText {
    return Intl.message(
      'Füge den Betrag des Beleges hinzu',
      name: 'totalHelperText',
      desc: '',
      args: [],
    );
  }

  /// `Bitte geben einen Betrag an`
  String get emptyTotal {
    return Intl.message(
      'Bitte geben einen Betrag an',
      name: 'emptyTotal',
      desc: '',
      args: [],
    );
  }

  /// `Betrag ist ungültig`
  String get invalidTotal {
    return Intl.message(
      'Betrag ist ungültig',
      name: 'invalidTotal',
      desc: '',
      args: [],
    );
  }

  /// `€`
  String get currency {
    return Intl.message(
      '€',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Sprache`
  String get language {
    return Intl.message(
      'Sprache',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message(
      'Wednesday',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get thursday {
    return Intl.message(
      'Thursday',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get friday {
    return Intl.message(
      'Friday',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get saturday {
    return Intl.message(
      'Saturday',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get sunday {
    return Intl.message(
      'Sunday',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `Ausgabenübersicht`
  String get overviewExpenses {
    return Intl.message(
      'Ausgabenübersicht',
      name: 'overviewExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Wochenübersicht`
  String get overview {
    return Intl.message(
      'Wochenübersicht',
      name: 'overview',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'de', countryCode: 'DE'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'GB'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}