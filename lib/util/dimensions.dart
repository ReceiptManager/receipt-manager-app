import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

class DimensionsCalculator {
  static var fallback_height = 250.0;
  static var banner_ration = 4;
  static var isCalculated = false;

  static double getBannerHeight(BuildContext context) {
    if (!isCalculated)
      fallback_height = MediaQuery.of(context).size.height / banner_ration;

    isCalculated = true;
    return fallback_height;
  }
}
