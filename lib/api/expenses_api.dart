import 'dart:developer';

import 'package:receipt_manager/database/receipt_database.dart';
import 'package:receipt_manager/math/math_util.dart';
import 'package:receipt_manager/memento/receipt_memento.dart';

/// # Expenses API
/// The expenses api handle various of expenses calculation tasks.
/// The [ExpensesApi] uses an singleton in order to submit
/// the same object.
///
/// First an initial call needs to be made, in order to calculate weekly expenses
/// and maximum but additionally, other features are planned.
class ExpensesApi {
  /// The [ReceiptMomentum] is used to store receipts in the list.
  /// This increase the performance, since no additionally database
  /// call is required
  ReceiptMemento _momentum = ReceiptMemento();

  /// Store weekly total and weekly maximum in a double
  double weeklyTotal = 0;
  double weeklyMaximum = 0;

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  /// Print double in fixed length
  String format(double amount, int decimalPlaces) {
    return amount.toStringAsFixed(decimalPlaces);
  }

  /// The [calculateWeekly] method is used to calculated the weekly maximum
  /// and total. This function should not be called from outside. Instead,
  /// the [init] method call the [calculateWeekly] method.
  void calculateWeekly() {
    final _date = DateTime.now();
    List<double> expenses = [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00];

    weeklyTotal = 0.00;
    weeklyMaximum = 0.00;
    final firstWeekDate =
        getDate(_date.subtract(Duration(days: _date.weekday - 1)));

    for (Receipt receipt in _momentum.receipts) {
      for (int i = 0; i < 7; i++) {
        // create an date object in order to increase the date
        // this allows to keep the code simple and
        // remove edge cases
        var currentDate = new DateTime(
            firstWeekDate.year, firstWeekDate.month, firstWeekDate.day + i);
        if (receipt.date.year == currentDate.year &&
            receipt.date.month == currentDate.month &&
            receipt.date.day == currentDate.day) {
          try {
            expenses[i] += double.parse(receipt.total.replaceAll(" ", ""));
          } catch (e) {
            log("[WARNING]: can't calculate receipt.");
          }
        }
        expenses[i] = MathUtil.roundDouble(expenses[i], 2);
        weeklyTotal += expenses[i];
      }
    }

    weeklyMaximum =
        expenses.reduce((current, next) => current > next ? current : next);
  }

  /// # API init method
  /// Main entry point of the expenses api.
  void init() {
    calculateWeekly();
  }
}
