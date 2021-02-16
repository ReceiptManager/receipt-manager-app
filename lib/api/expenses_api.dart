import 'dart:developer';

import 'package:receipt_manager/database/receipt_database.dart';
import 'package:receipt_manager/math/math_util.dart';
import 'package:receipt_manager/memento/receipt_memento.dart';

class ExpensesApi {
  ReceiptMemento _momentum = ReceiptMemento();

  // ignore: non_constant_identifier_names
  double WEEKLY_TOTAL = 0;
  // ignore: non_constant_identifier_names
  double WEEKLY_MAXIMUM = 0;

  List<double> expenses = [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00];

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  /// Print double in fixed length
  String format(double amount, int decimalPlaces) {
    return amount.toStringAsFixed(decimalPlaces);
  }

  /// Init data
  void init() {
    final _date = DateTime.now();
    expenses = [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00];
    WEEKLY_TOTAL = 0.00;
    final startDate =
        getDate(_date.subtract(Duration(days: _date.weekday - 1)));

    for (Receipt receipt in _momentum.receipts) {
      for (int i = 0; i < 7; i++) {
        var d =
            new DateTime(startDate.year, startDate.month, startDate.day + i);
        if (receipt.date.year == d.year &&
            receipt.date.month == d.month &&
            receipt.date.day == d.day) {
          try {
            expenses[i] += double.parse(receipt.total.replaceAll(" ", ""));
          } catch (e) {
            log("Can't process expenses, because an invalid entry appear");
            log("Ignoring ...");
          }
        }
      }
    }

    for (int i = 0; i < 7; i++) {
      expenses[i] = MathUtil.roundDouble(expenses[i], 2);
      WEEKLY_TOTAL += expenses[i];
    }
    WEEKLY_MAXIMUM =
        expenses.reduce((current, next) => current > next ? current : next);
  }
}
