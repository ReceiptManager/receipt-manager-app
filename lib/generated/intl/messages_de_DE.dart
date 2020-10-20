/*
 * Copyright (c) 2020 William Todt
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de_DE locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de_DE';

  final messages = _notInlinedMessages(_notInlinedMessages);

  static _notInlinedMessages(_) => <String, Function>{
        "addReceipt":
            MessageLookupByLibrary.simpleMessage("Kassenbeleg hinzufügen"),
        "appBarTitle":
            MessageLookupByLibrary.simpleMessage("Mein Haushaltsbuch"),
        "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "currency": MessageLookupByLibrary.simpleMessage("€"),
        "currentLanguage": MessageLookupByLibrary.simpleMessage("Deutsch"),
        "deleteReceipt": MessageLookupByLibrary.simpleMessage("Löschen"),
        "editReceipt": MessageLookupByLibrary.simpleMessage("Editieren"),
        "emptyStoreName": MessageLookupByLibrary.simpleMessage(
            "\'Bitte gebe einen Shop Namen an."),
        "emptyTotal":
            MessageLookupByLibrary.simpleMessage("Bitte geben einen Betrag an"),
        "enableDebugOutput": MessageLookupByLibrary.simpleMessage(
            "Entwicklerinformationen anzeigen"),
        "failedUpdateReceipt": MessageLookupByLibrary.simpleMessage(
            "Beleg wurde nicht aktualisiert"),
        "groceryCategory": MessageLookupByLibrary.simpleMessage("Lebensmittel"),
        "healthCategory": MessageLookupByLibrary.simpleMessage("Gesundheit"),
        "invalidInput":
            MessageLookupByLibrary.simpleMessage("Eingabe is ungültig"),
        "invalidServerIP": MessageLookupByLibrary.simpleMessage(
            "Die eingegebene IP war falsch. Bitte versuchen Sie es erneut"),
        "invalidTotal":
            MessageLookupByLibrary.simpleMessage("Betrag ist ungültig"),
        "openSourceLicence":
            MessageLookupByLibrary.simpleMessage("Open-Source Lizenzen"),
        "receiptDateDialog":
            MessageLookupByLibrary.simpleMessage("Please enter some date"),
        "receiptDateFormat": MessageLookupByLibrary.simpleMessage("dd.MM.YYYY"),
        "receiptDateHelperText": MessageLookupByLibrary.simpleMessage(
            "Füge das Datum das Kassenbeleg hinzu"),
        "receiptDateInvalid": MessageLookupByLibrary.simpleMessage(
            "Receipt date is invalid, format:"),
        "receiptDateLabelText": MessageLookupByLibrary.simpleMessage("Datum"),
        "receiptDateNotFormatted":
            MessageLookupByLibrary.simpleMessage("Eingabeformat ungültig"),
        "receiptEmpty": MessageLookupByLibrary.simpleMessage(
            "Bitte geben Sie ein Datum ein"),
        "receiptLoadFailed": MessageLookupByLibrary.simpleMessage(
            "Ein Fehler ist aufgetreten, Kassenbelege konnten nicht geladen werden"),
        "receiptSelectCategory":
            MessageLookupByLibrary.simpleMessage("Wähle eine Kategorie"),
        "serverIP" : MessageLookupByLibrary.simpleMessage("Server ip"),
    "serverIPHelpText" : MessageLookupByLibrary.simpleMessage("Zugangs-Server Addresse "),
    "serverIPLabelText" : MessageLookupByLibrary.simpleMessage("Server ip Addresse"),
    "serverSettings" : MessageLookupByLibrary.simpleMessage("Server Einstellungen"),
    "settingsDeveloperSubtitle" : MessageLookupByLibrary.simpleMessage("Entwickelerwerkzeuge"),
    "settingsDeveloperTitle" : MessageLookupByLibrary.simpleMessage("Entwickler"),
    "settingsDevelopmentTitle" : MessageLookupByLibrary.simpleMessage("Entwicklung"),
    "settingsGeneralCategory" : MessageLookupByLibrary.simpleMessage("Allgemein"),
    "settingsLanguageTitle" : MessageLookupByLibrary.simpleMessage("Sprache"),
    "settingsMiscTitle" : MessageLookupByLibrary.simpleMessage("Verschiedenes"),
    "settingsNetworkCategory" : MessageLookupByLibrary.simpleMessage("Netzwerk"),
    "settingsServerTitle" : MessageLookupByLibrary.simpleMessage("Netzwerk Einstellungen"),
    "storeNameHelper" : MessageLookupByLibrary.simpleMessage("Füge einen Shop Namen hinzu"),
    "storeNameHint" : MessageLookupByLibrary.simpleMessage("Shop Name"),
    "storeNameTitle" : MessageLookupByLibrary.simpleMessage("Shop Name"),
    "totalHelperText" : MessageLookupByLibrary.simpleMessage("Füge den Betrag des Beleges hinzu"),
    "totalLabelText" : MessageLookupByLibrary.simpleMessage("Betrag"),
    "totalTitle" : MessageLookupByLibrary.simpleMessage("Betrag"),
    "update" : MessageLookupByLibrary.simpleMessage("Aktualisieren"),
    "updateReceipt" : MessageLookupByLibrary.simpleMessage("Kassenbeleg aktualisieren"),
    "updateReceiptSuccessful" : MessageLookupByLibrary.simpleMessage("Beleg erfolgreich aktualisiert"),
    "updateServerIP" : MessageLookupByLibrary.simpleMessage("Zugangs-Server Addresse aktualisiert."),
    "uploadFailed" : MessageLookupByLibrary.simpleMessage("Bild konnte nicht hochgeladen werden"),
    "uploadSuccess" : MessageLookupByLibrary.simpleMessage("Bild erfolgreich hochgeladen")
  };
}
