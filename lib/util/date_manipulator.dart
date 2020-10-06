import 'package:intl/intl.dart';

class DateManipulator {
  static String humanDate(DateTime dateTime) {
    if (dateTime == null) return " ";

    return DateFormat("dd.MM.yyyy").format(dateTime);
  }
}
