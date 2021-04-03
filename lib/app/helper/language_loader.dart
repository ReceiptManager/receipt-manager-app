import 'dart:ui';

import 'package:receipt_manager/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EasyLanguageLoader {
  SharedPreferences _sharedPreferences;
  List<Locale> _sortedLocals;
  var _languageIndex = 0;

  EasyLanguageLoader(this._sharedPreferences);

  List<Locale> getLanguageArray() {
    if (_sortedLocals == null || _sortedLocals.length == 0) {
      List<Locale> locales = S.delegate.supportedLocales;
      List<Locale> _tmp = List.from(locales);
      _tmp.sort((Locale a, Locale b) => a.toString().compareTo(b.toString()));
      return _tmp;
    }

    return _sortedLocals;
  }

  void loadCurrentLanguage() {
    loadLanguageArray();

    if (!_sharedPreferences.containsKey("language")) return;

    String language = _sharedPreferences.getString("language");
    _languageIndex =
        _sortedLocals.indexWhere((element) => element.toString() == language);

    S.load(_sortedLocals[_languageIndex]);
  }

  int findLanguageIndex(String language) {
    loadLanguageArray();
    return _sortedLocals
        .indexWhere((element) => element.toString() == language);
  }

  void loadLanguageArray() {
    if (_sortedLocals == null || _sortedLocals.length == 0) {
      _sortedLocals = getLanguageArray();
    }
  }
}
