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
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:receipt_manager/app/pages/stats/stat_controller.dart';
import 'package:receipt_manager/app/widgets/stats/stats_card.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsPage extends View {
  @override
  State<StatefulWidget> createState() => StatsState();
}

class StatsState extends ViewState<StatsPage, StatsController> {
  StatsState() : super(StatsController());

  Widget getMonthChart() {
    List<ReceiptMonthData> data = [];

    int year = DateTime.now().year;
    return SfCartesianChart(primaryXAxis: CategoryAxis(),
        //tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          LineSeries<ReceiptMonthData, String>(
              name: "Receipt overview",
              color: Colors.red,
              dataSource: data,
              xValueMapper: (ReceiptMonthData data, _) =>
                  DateFormat.MMM().format((DateTime.utc(year, data.month, 0))),
              yValueMapper: (ReceiptMonthData data, _) => data.total)
        ]);
  }

  Widget getWeeklyChart() {
    List<WeeklyChartData> data = [];
    int year = DateTime.now().year;

    return SfCartesianChart(primaryXAxis: CategoryAxis(),
        //tooltipBehavior: _tooltipBehavior2,
        series: <ChartSeries>[
          ColumnSeries<WeeklyChartData, String>(
              color: Colors.red,
              name: "Receipt overview",
              dataSource: data,
              xValueMapper: (WeeklyChartData data, _) => DateFormat.E()
                  .format((DateTime.utc(year, data.date.month, data.date.day))),
              yValueMapper: (WeeklyChartData data, _) => data.total,
              enableTooltip: true,
              width: 0.75)
        ]);
  }

  Widget getYearOverview() {
    return StatsCard("Annual overview", "Expense overview", getMonthChart());
  }

  Widget getWeeklyOverview() {
    return StatsCard("Weekly overview", "Expenses overview", getWeeklyChart());
  }

  @override
  Widget get view => Material(
          child: Scaffold(
        key: globalKey,
        backgroundColor: Colors.white,
        appBar: NeumorphicAppBar(
          title: Text("Analytics"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[getYearOverview(), getWeeklyOverview()],
        )),
      ));
}
