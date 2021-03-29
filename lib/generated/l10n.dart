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
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
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

  /// `Beleg hinzugefügen`
  String get addReceipt {
    return Intl.message(
      'Beleg hinzugefügen',
      name: 'addReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Beleg hinzugefügt`
  String get addedReceipt {
    return Intl.message(
      'Beleg hinzugefügt',
      name: 'addedReceipt',
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

  /// `Füge das Datum das Beleg hinzu`
  String get receiptDateHelperText {
    return Intl.message(
      'Füge das Datum das Beleg hinzu',
      name: 'receiptDateHelperText',
      desc: '',
      args: [],
    );
  }

  /// `Bitte gebe ein Datum an`
  String get receiptDateDialog {
    return Intl.message(
      'Bitte gebe ein Datum an',
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

  /// `Ein Fehler ist aufgetreten, Belege konnten nicht geladen werden`
  String get receiptLoadFailed {
    return Intl.message(
      'Ein Fehler ist aufgetreten, Belege konnten nicht geladen werden',
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

  /// `Beleg aktualisieren`
  String get updateReceipt {
    return Intl.message(
      'Beleg aktualisieren',
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

  /// `Server IP`
  String get serverIP {
    return Intl.message(
      'Server IP',
      name: 'serverIP',
      desc: '',
      args: [],
    );
  }

  /// `Server IP Addresse`
  String get serverIPLabelText {
    return Intl.message(
      'Server IP Addresse',
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

  /// `Montag`
  String get monday {
    return Intl.message(
      'Montag',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Dienstag`
  String get tuesday {
    return Intl.message(
      'Dienstag',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Mittwoch`
  String get wednesday {
    return Intl.message(
      'Mittwoch',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Donnerstag`
  String get thursday {
    return Intl.message(
      'Donnerstag',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Freitag`
  String get friday {
    return Intl.message(
      'Freitag',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Samstag`
  String get saturday {
    return Intl.message(
      'Samstag',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sonntag`
  String get sunday {
    return Intl.message(
      'Sonntag',
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

  /// `Server Zeitüberschreibung`
  String get serverTimeout {
    return Intl.message(
      'Server Zeitüberschreibung',
      name: 'serverTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Keine Verbindung zum Server möglich`
  String get socketException {
    return Intl.message(
      'Keine Verbindung zum Server möglich',
      name: 'socketException',
      desc: '',
      args: [],
    );
  }

  /// `Zertifikat ungültig`
  String get handshakeException {
    return Intl.message(
      'Zertifikat ungültig',
      name: 'handshakeException',
      desc: '',
      args: [],
    );
  }

  /// `Etwas ist schief gelaufen`
  String get generalException {
    return Intl.message(
      'Etwas ist schief gelaufen',
      name: 'generalException',
      desc: '',
      args: [],
    );
  }

  /// `Server IP ist undefiniert.`
  String get serverIpIsNotSet {
    return Intl.message(
      'Server IP ist undefiniert.',
      name: 'serverIpIsNotSet',
      desc: '',
      args: [],
    );
  }

  /// `Unterhaltung`
  String get entertainment {
    return Intl.message(
      'Unterhaltung',
      name: 'entertainment',
      desc: '',
      args: [],
    );
  }

  /// `Überspringen`
  String get skip {
    return Intl.message(
      'Überspringen',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Analyisiere deine persönlichen Ausgaben.`
  String get startsDescription {
    return Intl.message(
      'Analyisiere deine persönlichen Ausgaben.',
      name: 'startsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Deine Ausgaben auf einem Blick`
  String get statsTitle {
    return Intl.message(
      'Deine Ausgaben auf einem Blick',
      name: 'statsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Füge deine Einkaufszettel aus Bildern hinzu`
  String get ocrTitle {
    return Intl.message(
      'Füge deine Einkaufszettel aus Bildern hinzu',
      name: 'ocrTitle',
      desc: '',
      args: [],
    );
  }

  /// `Durch tesseract können Bilder automatisch analysiert werden`
  String get ocrDescription {
    return Intl.message(
      'Durch tesseract können Bilder automatisch analysiert werden',
      name: 'ocrDescription',
      desc: '',
      args: [],
    );
  }

  /// `Weiter`
  String get next {
    return Intl.message(
      'Weiter',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Geschaft`
  String get done {
    return Intl.message(
      'Geschaft',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Keine Belege wurden hinzugefügt`
  String get noReceipts {
    return Intl.message(
      'Keine Belege wurden hinzugefügt',
      name: 'noReceipts',
      desc: '',
      args: [],
    );
  }

  /// `Miete`
  String get Rent {
    return Intl.message(
      'Miete',
      name: 'Rent',
      desc: '',
      args: [],
    );
  }

  /// `Essen`
  String get food {
    return Intl.message(
      'Essen',
      name: 'food',
      desc: '',
      args: [],
    );
  }

  /// `Sozialleistungen`
  String get employeeBenefits {
    return Intl.message(
      'Sozialleistungen',
      name: 'employeeBenefits',
      desc: '',
      args: [],
    );
  }

  /// `Sonstiges`
  String get util {
    return Intl.message(
      'Sonstiges',
      name: 'util',
      desc: '',
      args: [],
    );
  }

  /// `Reisen`
  String get travel {
    return Intl.message(
      'Reisen',
      name: 'travel',
      desc: '',
      args: [],
    );
  }

  /// `Bildung`
  String get education {
    return Intl.message(
      'Bildung',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// `Data N/A`
  String get noData {
    return Intl.message(
      'Data N/A',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Kategorieübersicht`
  String get expensesByCategory {
    return Intl.message(
      'Kategorieübersicht',
      name: 'expensesByCategory',
      desc: '',
      args: [],
    );
  }

  /// `Baumarkt`
  String get diySupermarkt {
    return Intl.message(
      'Baumarkt',
      name: 'diySupermarkt',
      desc: '',
      args: [],
    );
  }

  /// `Hinzufügen eines API token`
  String get insertYourApiToken {
    return Intl.message(
      'Hinzufügen eines API token',
      name: 'insertYourApiToken',
      desc: '',
      args: [],
    );
  }

  /// `API Token`
  String get apitoken {
    return Intl.message(
      'API Token',
      name: 'apitoken',
      desc: '',
      args: [],
    );
  }

  /// `Füge server API token hinzu`
  String get insertServerApiToken {
    return Intl.message(
      'Füge server API token hinzu',
      name: 'insertServerApiToken',
      desc: '',
      args: [],
    );
  }

  /// `Ungültiger API token`
  String get invalidApiToken {
    return Intl.message(
      'Ungültiger API token',
      name: 'invalidApiToken',
      desc: '',
      args: [],
    );
  }

  /// `Erfolgreich API token aktualisiert`
  String get updateApiTokenSuccessfully {
    return Intl.message(
      'Erfolgreich API token aktualisiert',
      name: 'updateApiTokenSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Erfolgreich receipt parser domain aktualisiert`
  String get updateWebsiteUrl {
    return Intl.message(
      'Erfolgreich receipt parser domain aktualisiert',
      name: 'updateWebsiteUrl',
      desc: '',
      args: [],
    );
  }

  /// `Übersicht`
  String get dashboard {
    return Intl.message(
      'Übersicht',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `OCR Einstellungen`
  String get ocr {
    return Intl.message(
      'OCR Einstellungen',
      name: 'ocr',
      desc: '',
      args: [],
    );
  }

  /// `Hoher Kontrast`
  String get highContrast {
    return Intl.message(
      'Hoher Kontrast',
      name: 'highContrast',
      desc: '',
      args: [],
    );
  }

  /// `Kamera Einstellungen`
  String get cameraSettings {
    return Intl.message(
      'Kamera Einstellungen',
      name: 'cameraSettings',
      desc: '',
      args: [],
    );
  }

  /// `Neuronal network parser`
  String get neuronalNetworkParser {
    return Intl.message(
      'Neuronal network parser',
      name: 'neuronalNetworkParser',
      desc: '',
      args: [],
    );
  }

  /// `Fuzzy Regel parser`
  String get fuzzyParser {
    return Intl.message(
      'Fuzzy Regel parser',
      name: 'fuzzyParser',
      desc: '',
      args: [],
    );
  }

  /// `Graustufenbild`
  String get grayscaleImage {
    return Intl.message(
      'Graustufenbild',
      name: 'grayscaleImage',
      desc: '',
      args: [],
    );
  }

  /// `Gauß'scher Weichzeichner `
  String get gaussianBlur {
    return Intl.message(
      'Gauß\'scher Weichzeichner ',
      name: 'gaussianBlur',
      desc: '',
      args: [],
    );
  }

  /// `Bild drehen um 90°`
  String get rotateImage {
    return Intl.message(
      'Bild drehen um 90°',
      name: 'rotateImage',
      desc: '',
      args: [],
    );
  }

  /// `Beleg anzeigen`
  String get receipt {
    return Intl.message(
      'Beleg anzeigen',
      name: 'receipt',
      desc: '',
      args: [],
    );
  }

  /// `Beleg scannen`
  String get takeAReceipt {
    return Intl.message(
      'Beleg scannen',
      name: 'takeAReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Lizenzen`
  String get licence {
    return Intl.message(
      'Lizenzen',
      name: 'licence',
      desc: '',
      args: [],
    );
  }

  /// `Open-Source Bibliotheken`
  String get opensourceLicences {
    return Intl.message(
      'Open-Source Bibliotheken',
      name: 'opensourceLicences',
      desc: '',
      args: [],
    );
  }

  /// `Ausgabe`
  String get outcome {
    return Intl.message(
      'Ausgabe',
      name: 'outcome',
      desc: '',
      args: [],
    );
  }

  /// `Einnahme`
  String get income {
    return Intl.message(
      'Einnahme',
      name: 'income',
      desc: '',
      args: [],
    );
  }

  /// `Trainingsdaten konnten nicht übermittelt werden`
  String get failedToSubmitTrainingData {
    return Intl.message(
      'Trainingsdaten konnten nicht übermittelt werden',
      name: 'failedToSubmitTrainingData',
      desc: '',
      args: [],
    );
  }

  /// `Übertrage Trainingsdaten`
  String get sendTrainingData {
    return Intl.message(
      'Übertrage Trainingsdaten',
      name: 'sendTrainingData',
      desc: '',
      args: [],
    );
  }

  /// `Produkt löschen`
  String get deleteProduct {
    return Intl.message(
      'Produkt löschen',
      name: 'deleteProduct',
      desc: '',
      args: [],
    );
  }

  /// `Produkt editieren`
  String get editProduct {
    return Intl.message(
      'Produkt editieren',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `Produkte`
  String get products {
    return Intl.message(
      'Produkte',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Artikel`
  String get itemTitle {
    return Intl.message(
      'Artikel',
      name: 'itemTitle',
      desc: '',
      args: [],
    );
  }

  /// `Artikel`
  String get itemLabelText {
    return Intl.message(
      'Artikel',
      name: 'itemLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Füge den Artikelnamen hinzu`
  String get itemHelperText {
    return Intl.message(
      'Füge den Artikelnamen hinzu',
      name: 'itemHelperText',
      desc: '',
      args: [],
    );
  }

  /// `Betrag`
  String get itemTotalTitle {
    return Intl.message(
      'Betrag',
      name: 'itemTotalTitle',
      desc: '',
      args: [],
    );
  }

  /// `Betrag`
  String get itemTotalLabelText {
    return Intl.message(
      'Betrag',
      name: 'itemTotalLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Füge den Betrag des Artikels hinzu`
  String get itemTotalHelperText {
    return Intl.message(
      'Füge den Betrag des Artikels hinzu',
      name: 'itemTotalHelperText',
      desc: '',
      args: [],
    );
  }

  /// `Bestätigen`
  String get confirm {
    return Intl.message(
      'Bestätigen',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Sonstiges`
  String get misc {
    return Intl.message(
      'Sonstiges',
      name: 'misc',
      desc: '',
      args: [],
    );
  }

  /// `Artikel anzeigen`
  String get showListView {
    return Intl.message(
      'Artikel anzeigen',
      name: 'showListView',
      desc: '',
      args: [],
    );
  }

  /// `Erkenne Receipt Server`
  String get detectReceiptServer {
    return Intl.message(
      'Erkenne Receipt Server',
      name: 'detectReceiptServer',
      desc: '',
      args: [],
    );
  }

  /// `Kein Receipt Server wurde gefunden`
  String get noReceiptServer {
    return Intl.message(
      'Kein Receipt Server wurde gefunden',
      name: 'noReceiptServer',
      desc: '',
      args: [],
    );
  }

  /// `No services found`
  String get noServicesFound {
    return Intl.message(
      'No services found',
      name: 'noServicesFound',
      desc: '',
      args: [],
    );
  }

  /// `Typ`
  String get type {
    return Intl.message(
      'Typ',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Aktiviere HTTPS`
  String get https {
    return Intl.message(
      'Aktiviere HTTPS',
      name: 'https',
      desc: '',
      args: [],
    );
  }

  /// `Monatsübersicht`
  String get monthOverview {
    return Intl.message(
      'Monatsübersicht',
      name: 'monthOverview',
      desc: '',
      args: [],
    );
  }

  /// `Jahresübersicht`
  String get yearOverview {
    return Intl.message(
      'Jahresübersicht',
      name: 'yearOverview',
      desc: '',
      args: [],
    );
  }

  /// `Reverse Proxy`
  String get reverseProxy {
    return Intl.message(
      'Reverse Proxy',
      name: 'reverseProxy',
      desc: '',
      args: [],
    );
  }

  /// `Reverse Proxy hinzufügen`
  String get insertReverseProxy {
    return Intl.message(
      'Reverse Proxy hinzufügen',
      name: 'insertReverseProxy',
      desc: '',
      args: [],
    );
  }

  /// `Website Einstellungen`
  String get websiteSettings {
    return Intl.message(
      'Website Einstellungen',
      name: 'websiteSettings',
      desc: '',
      args: [],
    );
  }

  /// `Netzwerk Einstellungen`
  String get networkSettings {
    return Intl.message(
      'Netzwerk Einstellungen',
      name: 'networkSettings',
      desc: '',
      args: [],
    );
  }

  /// `Unverschlüsselte Kommunikation wird nicht empfohlen`
  String get disableHttpsWarning {
    return Intl.message(
      'Unverschlüsselte Kommunikation wird nicht empfohlen',
      name: 'disableHttpsWarning',
      desc: '',
      args: [],
    );
  }

  /// `Verbindung konnte nicht hergestellt werden`
  String get connectionFailed {
    return Intl.message(
      'Verbindung konnte nicht hergestellt werden',
      name: 'connectionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Verbindung konnte hergestellt werden`
  String get connectionSuccess {
    return Intl.message(
      'Verbindung konnte hergestellt werden',
      name: 'connectionSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Erkenne Kanten`
  String get detectEdges {
    return Intl.message(
      'Erkenne Kanten',
      name: 'detectEdges',
      desc: '',
      args: [],
    );
  }

  /// `Tesseract Ergebnis anzeigen`
  String get showParsedReceipt {
    return Intl.message(
      'Tesseract Ergebnis anzeigen',
      name: 'showParsedReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Tag`
  String get tag {
    return Intl.message(
      'Tag',
      name: 'tag',
      desc: '',
      args: [],
    );
  }

  /// `Füge einen Tag für deinen Beleg hinzu`
  String get tagHelperText {
    return Intl.message(
      'Füge einen Tag für deinen Beleg hinzu',
      name: 'tagHelperText',
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