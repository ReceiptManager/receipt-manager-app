import 'dart:developer';

import 'package:receipt_manager/memento/receipt_memento.dart';
import 'package:receipt_manager/database/receipt_database.dart';
import 'package:receipt_manager/math/math_util.dart';

class ExpensesApi {
  ReceiptMemento _momentum = ReceiptMemento();

  double weekly_total = 0;
  double weekly_maximum = 0;

  List<double> expenses = [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00];

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  /// Print double in fixed length
  String format(double amount, int decimal_places) {
    return amount.toStringAsFixed(decimal_places);
  }

  /// Init data
  void init() {
      final _date = DateTime.now();
      expenses = [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00];
      weekly_total = 0.00;
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
            } catch(e) {
              log("Can't process expenses, because an invalid entry appear");
              log("Ignoring ...");
            }
          }
        }
      }

      for (int i = 0; i < 7; i++) {
        expenses[i] = MathUtil.roundDouble(expenses[i], 2);
        weekly_total += expenses[i];
      }
      weekly_maximum = expenses.reduce((current, next) => current > next ? current : next);
  }
}
