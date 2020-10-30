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
    "Rent" : MessageLookupByLibrary.simpleMessage("Rent"),
    "addReceipt" : MessageLookupByLibrary.simpleMessage("Add receipt"),
    "appBarTitle" : MessageLookupByLibrary.simpleMessage("Receipt manager"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "currency" : MessageLookupByLibrary.simpleMessage("\$"),
    "currentLanguage" : MessageLookupByLibrary.simpleMessage("English"),
    "deleteReceipt" : MessageLookupByLibrary.simpleMessage("Delete"),
    "done" : MessageLookupByLibrary.simpleMessage("Done"),
    "editReceipt" : MessageLookupByLibrary.simpleMessage("Update"),
    "employeeBenefits" : MessageLookupByLibrary.simpleMessage("Employee Benefits"),
    "emptyStoreName" : MessageLookupByLibrary.simpleMessage("\'Please enter a store name."),
    "emptyTotal" : MessageLookupByLibrary.simpleMessage("Please enter the total."),
    "enableDebugOutput" : MessageLookupByLibrary.simpleMessage("Enable debug output"),
    "entertainment" : MessageLookupByLibrary.simpleMessage("Entertainment"),
    "failedUpdateReceipt" : MessageLookupByLibrary.simpleMessage("Failed to update receipt"),
    "food" : MessageLookupByLibrary.simpleMessage("Food"),
    "friday" : MessageLookupByLibrary.simpleMessage("Friday"),
    "generalException" : MessageLookupByLibrary.simpleMessage("Ups something went wrong"),
    "groceryCategory" : MessageLookupByLibrary.simpleMessage("Grocery"),
    "handshakeException" : MessageLookupByLibrary.simpleMessage("Bad certificate. Please regenerate the certificate"),
    "healthCategory" : MessageLookupByLibrary.simpleMessage("Health"),
    "invalidInput" : MessageLookupByLibrary.simpleMessage("Input appears invalid."),
    "invalidServerIP" : MessageLookupByLibrary.simpleMessage("The given submitted server IP appear invalid. Please try again."),
    "invalidTotal" : MessageLookupByLibrary.simpleMessage("Total is invalid."),
    "language" : MessageLookupByLibrary.simpleMessage("Language"),
    "monday" : MessageLookupByLibrary.simpleMessage("Monday"),
    "next" : MessageLookupByLibrary.simpleMessage("Next"),
    "noReceipts" : MessageLookupByLibrary.simpleMessage("There are no receipts inserted."),
    "ocrDescription" : MessageLookupByLibrary.simpleMessage("Parse receipts using optical character recognition."),
    "ocrTitle" : MessageLookupByLibrary.simpleMessage("Parse receipt via tesseract"),
    "openSourceLicence" : MessageLookupByLibrary.simpleMessage("Open source licenses"),
    "overview" : MessageLookupByLibrary.simpleMessage("Weekly overview"),
    "overviewExpenses" : MessageLookupByLibrary.simpleMessage("Expenses overview"),
    "receiptDateDialog" : MessageLookupByLibrary.simpleMessage("Please enter some date"),
    "receiptDateFormat" : MessageLookupByLibrary.simpleMessage("dd.MM.y"),
    "receiptDateHelperText" : MessageLookupByLibrary.simpleMessage("Set the receipt date"),
    "receiptDateInvalid" : MessageLookupByLibrary.simpleMessage("Receipt date is invalid, format:"),
    "receiptDateLabelText" : MessageLookupByLibrary.simpleMessage("Receipt date"),
    "receiptDateNotFormatted" : MessageLookupByLibrary.simpleMessage("Date is not formatted"),
    "receiptEmpty" : MessageLookupByLibrary.simpleMessage("Please enter some date"),
    "receiptLoadFailed" : MessageLookupByLibrary.simpleMessage("Error Occur, could not load receipts"),
    "receiptSelectCategory" : MessageLookupByLibrary.simpleMessage("Select receipt category"),
    "saturday" : MessageLookupByLibrary.simpleMessage("Saturday"),
    "serverIP" : MessageLookupByLibrary.simpleMessage("Server ip"),
    "serverIPHelpText" : MessageLookupByLibrary.simpleMessage("Set the image server ip"),
    "serverIPLabelText" : MessageLookupByLibrary.simpleMessage("Server ip address"),
    "serverIpIsNotSet" : MessageLookupByLibrary.simpleMessage("Server ip is not set."),
    "serverSettings" : MessageLookupByLibrary.simpleMessage("Server Settings"),
    "serverTimeout" : MessageLookupByLibrary.simpleMessage("Server timeout"),
    "settingsDeveloperSubtitle" : MessageLookupByLibrary.simpleMessage("Developer utils"),
    "settingsDeveloperTitle" : MessageLookupByLibrary.simpleMessage("Developer"),
    "settingsDevelopmentTitle" : MessageLookupByLibrary.simpleMessage("Development"),
    "settingsGeneralCategory" : MessageLookupByLibrary.simpleMessage("Common"),
    "settingsLanguageTitle" : MessageLookupByLibrary.simpleMessage("Language"),
    "settingsMiscTitle" : MessageLookupByLibrary.simpleMessage("Misc"),
    "settingsNetworkCategory" : MessageLookupByLibrary.simpleMessage("Network"),
    "settingsServerTitle" : MessageLookupByLibrary.simpleMessage("Server"),
    "skip" : MessageLookupByLibrary.simpleMessage("Skip"),
    "socketException" : MessageLookupByLibrary.simpleMessage("Can\'t connect to the server"),
    "startsDescription" : MessageLookupByLibrary.simpleMessage("Analyse personal expenses with detailed charts and filter categories."),
    "statsTitle" : MessageLookupByLibrary.simpleMessage("Track your expenses with statistics"),
    "storeNameHelper" : MessageLookupByLibrary.simpleMessage("Set the store name"),
    "storeNameHint" : MessageLookupByLibrary.simpleMessage("Store name"),
    "storeNameTitle" : MessageLookupByLibrary.simpleMessage("Store name"),
    "sunday" : MessageLookupByLibrary.simpleMessage("Sunday"),
    "thursday" : MessageLookupByLibrary.simpleMessage("Thursday"),
    "totalHelperText" : MessageLookupByLibrary.simpleMessage("Receipt total"),
    "totalLabelText" : MessageLookupByLibrary.simpleMessage("Receipt total"),
    "totalTitle" : MessageLookupByLibrary.simpleMessage("Receipt total"),
    "travel" : MessageLookupByLibrary.simpleMessage("Travel"),
    "tuesday" : MessageLookupByLibrary.simpleMessage("Tuesday"),
    "update" : MessageLookupByLibrary.simpleMessage("Update"),
    "updateReceipt" : MessageLookupByLibrary.simpleMessage("Update Receipt"),
    "updateReceiptSuccessful" : MessageLookupByLibrary.simpleMessage("Update receipt successfully"),
    "updateServerIP" : MessageLookupByLibrary.simpleMessage("Server ip is set."),
    "uploadFailed" : MessageLookupByLibrary.simpleMessage("Failed to upload image."),
    "uploadSuccess" : MessageLookupByLibrary.simpleMessage("Image successfully uploaded."),
    "util" : MessageLookupByLibrary.simpleMessage("Util"),
    "wednesday" : MessageLookupByLibrary.simpleMessage("Wednesday")
  };
}
