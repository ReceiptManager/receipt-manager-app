import 'package:flutter/material.dart';

class DimensionsCalculator {
  static var height = 250.0;
  static var banner = 4;
  static var isCalculated = false;

  static double getBannerHeight(BuildContext context) {
    if (!isCalculated)
      height = MediaQuery.of(context).size.height / banner;

    isCalculated = true;
    return height;
  }
}
