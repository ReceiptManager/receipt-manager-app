/*
 * Copyright (c) 2020 - 2021 : William Todt
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:receipt_manager/db/receipt_database.dart';
import 'package:receipt_manager/db/model/receipt_category.dart';

class LogoFactory {
  final Receipt _receipt;
  final BuildContext context;
  final String assetsLogoPrefix = "assets/";

  LogoFactory(this._receipt, this.context);

  String buildPath() {
    Map userMap = jsonDecode(_receipt.category);
    var category = ReceiptCategory.fromJson(userMap);
    String path = category.path;

    String _fallback =
        assetsLogoPrefix + path.split(" ")[0].toLowerCase().trim() + ".png";

    return _fallback;
  }
}
