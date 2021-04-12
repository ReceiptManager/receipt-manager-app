import 'package:flutter/material.dart';

class PaddingWidget extends StatelessWidget {
  final Widget widget;

  PaddingWidget({required this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(8.0), child: widget);
  }
}
