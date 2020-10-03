import 'package:flutter/material.dart';
import 'package:receipt_parser/form/form.dart';

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: MyCustomForm(),
    );
  }
}
