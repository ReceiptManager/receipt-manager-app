import 'package:flutter/material.dart';
import 'package:receipt_parser/ui/receipt_form.dart';

class StatsWidget extends StatelessWidget {
  StatsWidget();

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blueAccent, child: EmptyReceiptForm());
  }
}
