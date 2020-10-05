import 'package:intl/intl.dart';

class DateManipulator {
  static String humanDate(DateTime dateTime) {
    return DateFormat("dd.MM.yyyy").format(dateTime);
  }
}
