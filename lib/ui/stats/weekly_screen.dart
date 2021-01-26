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

import 'dart:math' as l;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:receipt_manager/database/receipt_database.dart';
import 'package:receipt_manager/factory/padding_factory.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/math/math_util.dart';

class WeeklyOverviewScreen extends StatefulWidget {
  final List<Receipt> receipt;

  WeeklyOverviewScreen(this.receipt);

  @override
  _WeeklyOverviewScreenState createState() =>
      _WeeklyOverviewScreenState(receipt);
}

class _WeeklyOverviewScreenState extends State<WeeklyOverviewScreen> {
  final Duration animDuration = const Duration(milliseconds: 250);
  List<double> expenses = [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00];
  double max = 0.00;
  double sum = 0.00;

  int touchIndexWeekly;
  List<Receipt> receipts;

  _WeeklyOverviewScreenState(this.receipts);

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  void generateData() {
    final _date = DateTime.now();
    expenses = [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00];
    sum = 0.00;
    final startDate =
        getDate(_date.subtract(Duration(days: _date.weekday - 1)));

    for (Receipt receipt in receipts) {
      for (int i = 0; i < 7; i++) {
        var d =
            new DateTime(startDate.year, startDate.month, startDate.day + i);
        if (receipt.date.year == d.year &&
            receipt.date.month == d.month &&
            receipt.date.day == d.day) {
          expenses[i] += double.parse(receipt.total);
        }
      }
    }

    for (int i = 0; i < 7; i++) {
      expenses[i] = MathUtil.roundDouble(expenses[i], 2);
      sum += expenses[i];
    }
    max = expenses.reduce((current, next) => current > next ? current : next);
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.red,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    double maxY = (max + l.log(max) / l.log(2) * 2);
    if (maxY < 10) {
      maxY = 20;
    }

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.pink] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            colors: [Colors.green],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, expenses[0],
                isTouched: i == touchIndexWeekly);
          case 1:
            return makeGroupData(1, expenses[1],
                isTouched: i == touchIndexWeekly);
          case 2:
            return makeGroupData(2, expenses[2],
                isTouched: i == touchIndexWeekly);
          case 3:
            return makeGroupData(3, expenses[3],
                isTouched: i == touchIndexWeekly);
          case 4:
            return makeGroupData(4, expenses[4],
                isTouched: i == touchIndexWeekly);
          case 5:
            return makeGroupData(5, expenses[5],
                isTouched: i == touchIndexWeekly);
          case 6:
            return makeGroupData(6, expenses[6],
                isTouched: i == touchIndexWeekly);
          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.black,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = S.of(context).monday;
                  break;
                case 1:
                  weekDay = S.of(context).thursday;
                  break;
                case 2:
                  weekDay = S.of(context).wednesday;
                  break;
                case 3:
                  weekDay = S.of(context).thursday;
                  break;
                case 4:
                  weekDay = S.of(context).friday;
                  break;
                case 5:
                  weekDay = S.of(context).saturday;
                  break;
                case 6:
                  weekDay = S.of(context).sunday;
                  break;
              }
              return BarTooltipItem(weekDay + '\n' + (rod.y - 1).toString(),
                  TextStyle(color: Colors.red));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchIndexWeekly = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchIndexWeekly = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return S.of(context).monday[0];
              case 1:
                return S.of(context).thursday[0];
              case 2:
                return S.of(context).wednesday[0];
              case 3:
                return S.of(context).thursday[0];
              case 4:
                return S.of(context).friday[0];
              case 5:
                return S.of(context).saturday[0];
              case 6:
                return S.of(context).sunday[0];
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  @override
  Widget build(BuildContext context) {
    generateData();

    return PaddingFactory.create(AspectRatio(
      aspectRatio: 1.2,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    S.of(context).overview,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    S.of(context).overviewExpenses,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    sum.toStringAsFixed(2) + S.of(context).currency,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}
