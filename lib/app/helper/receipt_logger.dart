import 'dart:developer';

class ReceiptLogger {
  static void logger(String storeName, String total, String date, String tag) {
    log("StoreName:" + storeName);
    log("Total:" + total);
    log("Date:" + date);
    log("Tag: " + tag);
  }
}

enum LOG_LEVEL { DEBUG, VERBOSE, DEFAULT }
