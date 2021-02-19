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
import 'package:receipt_manager/util/curved_painter.dart';
import 'package:receipt_manager/util/dimensions.dart';

enum BANNER_MODES { ADD_RECEIPT, DASHBOARD, OVERVIEW_EXPENSES }

class BannerFactory {
  static get(BANNER_MODES modes, BuildContext context) {
    String content;
    switch (modes) {
      case BANNER_MODES.ADD_RECEIPT:
        content = S.of(context).addReceipt;
        break;
      case BANNER_MODES.DASHBOARD:
        content = S.of(context).dashboard;
        break;
      case BANNER_MODES.OVERVIEW_EXPENSES:
        content = S.of(context).overviewExpenses;
        break;
    }

    String ft;
    String st;
    Stack banner;

    List<String> contentArr = content.split(" ");
    String firstText = "";
    String secondText = "";

    if (contentArr.length == 2) {
      secondText = content.split(" ")[1];
    }

    firstText = content.split(" ")[0] + " ";
    firstText = firstText == null ? "" : firstText;
    secondText = secondText == null ? "" : secondText;

    if (firstText == ft && secondText == st && banner != null) {
      return banner;
    }

    banner = Stack(
      children: [
        CustomPaint(
          child: Container(
            height: DimensionsCalculator.getBannerHeight(context),
          ),
          painter: CurvePainter(),
        ),
        Align(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(
                    top: DimensionsCalculator.getBannerHeight(context) / 3.5),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(firstText,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Text(secondText,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white))
                        ],
                      ),
                    ),
                  ],
                ))),
      ],
    );

    return banner;
  }
}
