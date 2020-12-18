/*
 *  Copyright (c) 2020 - William Todt
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:receipt_manager/database/receipt_database.dart';
import 'package:receipt_manager/factory/categories_factory.dart';
import 'package:receipt_manager/factory/padding_factory.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/model/receipt_category.dart';
import 'package:receipt_manager/theme/color/color.dart';

import 'indicator.dart';

class CategoryOverviewScreen extends StatefulWidget {
  final List<Receipt> receipts;

  const CategoryOverviewScreen(this.receipts);

  @override
  _CategoryOverviewScreenState createState() =>
      _CategoryOverviewScreenState(receipts);
}

class _CategoryOverviewScreenState extends State<CategoryOverviewScreen> {
  /// Current loaded receipts
  final List<Receipt> receipts;

  /// Show color if no receipts are inserted
  final Color notAvailableColor = LightColor.grey;

  /// Show the corresponding category if
  /// receipt category is shown
  int touchIndexCategories;

  /// Initialize the appbar only once
  bool initSectionData = false;

  /// contain current pie secretions
  List<PieChartSectionData> data = [];

  /// Contain category frequencies
  List<double> frequency;

  /// Color codes for each bar chart
  List<Color> colorCode;

  // Number of non empty categories
  int count;

  /// Receipt total
  double total;

  /// pie tiles
  List<Widget> widgets;

  /// Category constructor
  _CategoryOverviewScreenState(this.receipts);

  @override
  void initState() {
    List<ReceiptCategory> categories = ReceiptCategoryFactory.get(context);
    super.initState();

    widgets = [];
    frequency = [];
    total = 0;
    colorCode = [];

    if (receipts.isEmpty) {
      widgets.add(Indicator(
        color: notAvailableColor,
        text: S.of(context).noData,
        isSquare: false,
      ));

      widgets.add(SizedBox(
        height: 18,
      ));
    }

    RandomColor _rand = RandomColor();
    for (int i = 0; i < categories.length; i++) {
      frequency.add(0);
      colorCode.add(_rand.randomColor());

      for (var receipt in receipts) {
        if (ReceiptCategory.fromJson(jsonDecode(receipt.category)).name ==
            categories[i].name) {
          total += double.parse(receipt.total);
          if (i + 1 != categories.length) {
            if (frequency[i] == 0.00) {
              widgets.add(Indicator(
                color: colorCode[i],
                text: categories[i].name,
                isSquare: true,
              ));
              widgets.add(SizedBox(
                height: 4,
              ));
              frequency[i] += double.parse(receipt.total);
            } else {
              frequency[i] += double.parse(receipt.total);
            }
          } else {
            widgets.add(Indicator(
              color: notAvailableColor,
              text: categories[i].name,
              isSquare: false,
            ));
          }
        }
      }
    }

    widgets.add(SizedBox(
      height: 18,
    ));

    count = 0;
    for (int i = 0; i < frequency.length; i++) {
      if (frequency[i] != 0.00) count++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PaddingFactory.create(AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.white,
        child: Column(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      S.of(context).expensesByCategory,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      S.of(context).overviewExpenses,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 38,
                ),
              ]),
          Row(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: PieChart(
                    PieChartData(
                        pieTouchData:
                            PieTouchData(touchCallback: (pieTouchResponse) {
                          setState(() {
                            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                pieTouchResponse.touchInput is FlPanEnd) {
                              touchIndexCategories = -1;
                            } else {
                              setState(() {
                                touchIndexCategories =
                                    pieTouchResponse.touchedSectionIndex;
                              });
                            }
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections()),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgets,
              ),
              const SizedBox(
                width: 28,
              ),
            ],
          )
        ]),
      ),
    ));
  }

  List<PieChartSectionData> showingSections() {
    if (receipts.isEmpty) {
      return List.generate(1, (i) {
        final isTouched = i == touchIndexCategories;
        final double fontSize = isTouched ? 25 : 16;
        final double radius = isTouched ? 60 : 50;

        return PieChartSectionData(
            color: notAvailableColor,
            value: 100,
            title: '100%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: notAvailableColor,
            ));
      });
    }

    return List.generate(count, (i) {
      final isTouched = i == touchIndexCategories;
      double radius = 50;
      setState(() {
        radius = isTouched ? 80 : 50;
      });

      if (!initSectionData) {
        for (int i = 0; i < frequency.length; i++) {
          if (frequency[i] == 0) continue;

          data.add(PieChartSectionData(
            color: colorCode[i],
            value: 15,
            title: (frequency[i] / total * 100).toStringAsFixed(2) + "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xffffffff)),
          ));
        }
        initSectionData = true;
      }
      return data[i];
    });
  }
}
