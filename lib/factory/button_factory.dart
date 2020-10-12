import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:receipt_parser/converter/color_converter.dart';
import 'package:receipt_parser/theme/theme_manager.dart';

/// Since most of the buttons use the same style
/// The factory create a unique button with the custom style.
class ButtonFactory {
  static IconButton buildDateButton(DateTime receiptDate,
      TextEditingController dateController, BuildContext context) {
    return IconButton(
        color: HexColor.fromHex("#232F34"),
        icon: Icon(
          Icons.calendar_today,
          color: Colors.purple,
        ),
        onPressed: () async {
          receiptDate = await showDatePicker(
              builder: (BuildContext context, Widget child) {
                return Theme(
                  data: ThemeManager.getTheme(),
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
