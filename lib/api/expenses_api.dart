import 'package:receipt_manager/api/weekly_api.dart';

/// # Expenses API
/// The expenses api handle various of expenses calculation tasks.
/// The [ExpensesApi] uses an singleton in order to submit
/// the same object.
///
/// First an initial call needs to be made, in order to calculate weekly expenses
/// and maximum but additionally, other features are planned.
class ExpensesApi {
  WeeklyApi weeklyApi = WeeklyApi();

  /// Store weekly total and weekly maximum in a double
  double weeklyTotal = 0;
  double weeklyMaximum = 0;

  /// Print double in fixed length
  String format(double amount, int decimalPlaces) {
    return amount.toStringAsFixed(decimalPlaces);
  }

  /// # API init method
  /// Main entry point of the expenses api.
  void init() {
    weeklyApi.execute();

    weeklyTotal = weeklyApi.weeklyTotal;
    weeklyMaximum = weeklyApi.weeklyMaximum;
  }
}
