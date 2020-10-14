import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:receipt_parser/theme/theme_manager.dart';

/// Since most of the buttons use the same style
/// The factory create a unique button with the custom style.
class ButtonFactory {
  static IconButton buildDateButton(DateTime receiptDate,
      TextEditingController dateController, BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.calendar_today,
          color: Colors.purple,
        ),
        splashColor: ThemeManager.getYellow(),
        color: Colors.black,
        onPressed: () async {
          receiptDate = await showDatePicker(
              builder: (BuildContext context, Widget child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: ThemeManager.getYellow(),
                    accentColor: ThemeManager.getYellow(),
                    colorScheme:
                        ColorScheme.light(primary: const Color(0XFFF9AA33)),
                    buttonTheme:
                        ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child,
                );
              },
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2010),
              lastDate: DateTime(2050));
          dateController.text = DateFormat("dd.MM.yyyy").format(receiptDate);
        });
  }
}
