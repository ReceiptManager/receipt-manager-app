import 'package:flutter/material.dart';
import 'package:receipt_parser/database/receipt_database.dart';

class LogoFactory {
  final Receipt _receipt;
  final BuildContext context;
  final String assetsLogoPrefix = "assets/";

  LogoFactory(this._receipt, this.context);

  String buildPath() {
    String _fallback = assetsLogoPrefix +
        _receipt.category.split(" ")[0].toLowerCase().trim() +
        ".png";

    return _fallback;
  }
}
