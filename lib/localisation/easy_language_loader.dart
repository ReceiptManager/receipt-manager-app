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
