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

import 'package:flutter/material.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EasyLanguageLoader {
  SharedPreferences sharedPreferences;
  List<Locale> sortedLocals;
  var languageIndex = 0;

  EasyLanguageLoader(this.sharedPreferences);

  List<Locale> getLanguageArray() {
    if (sortedLocals == null || sortedLocals.length == 0) {
      List<Locale> locales = S.delegate.supportedLocales;
      List<Locale> _tmp;
      _tmp = List.from(locales);
      _tmp.sort((Locale a, Locale b) => a.toString().compareTo(b.toString()));
      return _tmp;
    }

    return sortedLocals;
  }

  void loadCurrentLanguage() {
    loadLanguageArray();

    if (!sharedPreferences.containsKey("language")) return;

    String language = sharedPreferences.getString("language");
    languageIndex =
        sortedLocals.indexWhere((element) => element.toString() == language);

    S.load(sortedLocals[languageIndex]);
  }

  int findLanguageIndex(String language) {
    loadLanguageArray();
    return sortedLocals.indexWhere((element) => element.toString() == language);
  }

  void loadLanguageArray() {
    if (sortedLocals == null || sortedLocals.length == 0) {
      sortedLocals = getLanguageArray();
    }
  }
}
