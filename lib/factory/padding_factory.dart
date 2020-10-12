import 'package:flutter/cupertino.dart';

class PaddingFactory {
  static double edgeSize = 8.0;

  static Padding create(Widget e) {
    return new Padding(padding: EdgeInsets.all(edgeSize), child: e);
  }
}
