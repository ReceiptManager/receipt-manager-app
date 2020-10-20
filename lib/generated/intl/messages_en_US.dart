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
// This is a library that provides messages for a en_US locale. All the
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
  String get localeName => 'en_US';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addReceipt" : MessageLookupByLibrary.simpleMessage("Add receipt"),
    "appBarTitle" : MessageLookupByLibrary.simpleMessage("Receipt manager"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "deleteReceipt" : MessageLookupByLibrary.simpleMessage("Delete"),
    "editReceipt" : MessageLookupByLibrary.simpleMessage("Update"),
    "emptyStoreName" : MessageLookupByLibrary.simpleMessage("\'Please enter a store name."),
    "emptyTotal" : MessageLookupByLibrary.simpleMessage("Please enter the total."),
    "enableDebugOutput" : MessageLookupByLibrary.simpleMessage("Enable debug output"),
    "failedUpdateReceipt" : MessageLookupByLibrary.simpleMessage("Failed to update receipt"),
    "groceryCategory" : MessageLookupByLibrary.simpleMessage("Grocery"),
    "healthCategory" : MessageLookupByLibrary.simpleMessage("Health"),
    "invalidInput" : MessageLookupByLibrary.simpleMessage("Input appears invalid."),
    "invalidServerIP" : MessageLookupByLibrary.simpleMessage("The given submitted server IP appear invalid. Please try again."),
    "invalidTotal" : MessageLookupByLibrary.simpleMessage("Total is invalid."),
    "openSourceLicence" : MessageLookupByLibrary.simpleMessage("Open source licenses"),
    "receiptDateDialog" : MessageLookupByLibrary.simpleMessage("Please enter some date"),
    "receiptDateFormat" : MessageLookupByLibrary.simpleMessage("dd.MM.YYYY"),
    "receiptDateHelperText" : MessageLookupByLibrary.simpleMessage("Set the receipt date"),
    "receiptDateInvalid" : MessageLookupByLibrary.simpleMessage("Receipt date is invalid, format:"),
    "receiptDateLabelText" : MessageLookupByLibrary.simpleMessage("Receipt date"),
    "receiptDateNotFormatted" : MessageLookupByLibrary.simpleMessage("Date is not formatted"),
    "receiptEmpty" : MessageLookupByLibrary.simpleMessage("Please enter some date"),
    "receiptLoadFailed" : MessageLookupByLibrary.simpleMessage("Error Occur, could not load receipts"),
    "receiptSelectCategory" : MessageLookupByLibrary.simpleMessage("Select receipt category"),
    "serverIP" : MessageLookupByLibrary.simpleMessage("Server ip"),
    "serverIPHelpText" : MessageLookupByLibrary.simpleMessage("Set the image server ip"),
    "serverIPLabelText" : MessageLookupByLibrary.simpleMessage("Server ip address"),
    "serverSettings" : MessageLookupByLibrary.simpleMessage("Server Settings"),
    "settingsDeveloperSubtitle" : MessageLookupByLibrary.simpleMessage("Developer utils"),
    "settingsDeveloperTitle" : MessageLookupByLibrary.simpleMessage("Developer"),
    "settingsDevelopmentTitle" : MessageLookupByLibrary.simpleMessage("Development"),
    "settingsGeneralCategory" : MessageLookupByLibrary.simpleMessage("Common"),
    "settingsLanguageSubtitle" : MessageLookupByLibrary.simpleMessage("English"),
    "settingsLanguageTitle" : MessageLookupByLibrary.simpleMessage("Language"),
    "settingsMiscTitle" : MessageLookupByLibrary.simpleMessage("Misc"),
    "settingsNetworkCategory" : MessageLookupByLibrary.simpleMessage("Network"),
    "settingsServerTitle" : MessageLookupByLibrary.simpleMessage("Server"),
    "storeNameHelper" : MessageLookupByLibrary.simpleMessage("Set the store name"),
    "storeNameHint" : MessageLookupByLibrary.simpleMessage("Store name"),
    "storeNameTitle" : MessageLookupByLibrary.simpleMessage("Store name"),
    "totalHelperText" : MessageLookupByLibrary.simpleMessage("Receipt total"),
    "totalLabelText" : MessageLookupByLibrary.simpleMessage("Receipt total"),
    "totalTitle" : MessageLookupByLibrary.simpleMessage("Receipt total"),
    "update" : MessageLookupByLibrary.simpleMessage("Update"),
    "updateReceipt" : MessageLookupByLibrary.simpleMessage("Update Receipt"),
    "updateReceiptSuccessful" : MessageLookupByLibrary.simpleMessage("Update receipt successfully"),
    "updateServerIP" : MessageLookupByLibrary.simpleMessage("Server ip is set."),
    "uploadFailed" : MessageLookupByLibrary.simpleMessage("Failed to upload image."),
    "uploadSuccess" : MessageLookupByLibrary.simpleMessage("Image successfully uploaded.")
  };
}
