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
import 'dart:developer';

import 'package:currency_pickers/country.dart';
import 'package:currency_pickers/currency_picker_cupertino.dart';
import 'package:currency_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/ui/settings/settings_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ConcurrencySetting extends StatefulWidget {
  SharedPreferences sharedPreferences;

  ConcurrencySetting(this.sharedPreferences);

  @override
  _ConcurrencySettingState createState() =>
      _ConcurrencySettingState(this.sharedPreferences);
}

class _ConcurrencySettingState extends State<ConcurrencySetting> {
  SharedPreferences sharedPreferences;

  Country _selected = CurrencyPickerUtils.getCountryByIsoCode('US');

  _ConcurrencySettingState(this.sharedPreferences);

  Widget _buildCupertinoSelectedItem(Country country) {
    return Row(
      children: <Widget>[
        CurrencyPickerUtils.getDefaultFlagImage(country),
        SizedBox(width: 8.0),
        Text("+${country.currencyCode}"),
        SizedBox(width: 8.0),
        Flexible(child: Text(country.name))
      ],
    );
  }

  Widget _buildCupertinoItem(Country country) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.white,
        fontSize: 16.0,
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 8.0),
          CurrencyPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text("+${country.currencyCode}"),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      ),
    );
  }

  void _openCupertinoCurrencyPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CurrencyPickerCupertino(
          backgroundColor: Colors.black,
          itemBuilder: _buildCupertinoItem,
          pickerSheetHeight: 300.0,
          pickerItemHeight: 75,
          initialCountry: _selected,
          onValuePicked: (Country country) => setState(() {
            String currency =
                CurrencyPickerUtils.getCountryByIsoCode(country.isoCode)
                    .currencyCode
                    .toString();

            sharedPreferences.setString(
                SharedPreferenceKeyHolder.lang, currency);

            log(currency);

            _selected = country;
          }),
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(S.of(context).concurrencyTitle)),
        body: ListView(padding: EdgeInsets.all(8.0), children: <Widget>[
          Card(
            child: ListTile(
              title: _buildCupertinoSelectedItem(_selected),
              onTap: _openCupertinoCurrencyPicker,
            ),
          ),
        ]));
  }
}
