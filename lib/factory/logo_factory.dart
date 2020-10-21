/*
 * Copyright (c) 2020 - William Todt
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
