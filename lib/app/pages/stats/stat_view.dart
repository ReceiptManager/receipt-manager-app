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
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:receipt_manager/app/pages/stats/stat_controller.dart';
import 'package:receipt_manager/app/widgets/stats/stats_card.dart';
import 'package:receipt_manager/data/helpers/category_chart.dart';
import 'package:receipt_manager/data/helpers/month_chart.dart';
import 'package:receipt_manager/data/helpers/weekly_chart.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';
import 'package:receipt_manager/data/storage/scheme/holder_table.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsPage extends View {
  @override
  State<StatefulWidget> createState() => StatsState();
}

class StatsState extends ViewState<StatsPage, StatsController> {
  StatsState() : super(StatsController(DataReceiptRepository()));
  TooltipBehavior monthToolTip = TooltipBehavior(enable: true);
  TooltipBehavior weekToolTip = TooltipBehavior(enable: true);
  TooltipBehavior categoryToolTip = TooltipBehavior(enable: true);

  Widget getMonthChart(List<ReceiptHolder> receipts) {
    MonthlyOverview overview = MonthlyOverview(receipts);
    List<ReceiptMonthData> data = overview.getData();

    int year = DateTime.now().year;
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        tooltipBehavior: monthToolTip,
        series: <ChartSeries>[
          LineSeries<ReceiptMonthData, String>(
              name: "Monthly Total",
              color: Colors.red,
              dataSource: data,
              xValueMapper: (ReceiptMonthData data, _) =>
                  DateFormat.MMM().format((DateTime.utc(year, data.month, 0))),
              yValueMapper: (ReceiptMonthData data, _) => data.total)
        ]);
  }

  Widget getWeeklyChart(List<ReceiptHolder> receipts) {
    WeeklyOverview overview = WeeklyOverview(receipts);
    List<WeeklyChartData> data = overview.getData();
    int year = DateTime.now().year;

    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        tooltipBehavior: weekToolTip,
        series: <ChartSeries>[
          ColumnSeries<WeeklyChartData, String>(
              color: Colors.red,
              name: "Weekly total",
              dataSource: data,
              xValueMapper: (WeeklyChartData data, _) => DateFormat.E()
                  .format((DateTime.utc(year, data.date.month, data.date.day))),
              yValueMapper: (WeeklyChartData data, _) => data.total,
              enableTooltip: true,
              width: 0.75)
        ]);
  }

  Widget getCategoryChart(List<ReceiptHolder> receipts) {
    CategoryOverview overview = CategoryOverview(receipts);
    List<CategoryData> data = overview.getData();

    if (data.isEmpty) return Container();
    return SfCircularChart(
        legend: Legend(isVisible: true),
        tooltipBehavior: categoryToolTip,
        series: <CircularSeries>[
          PieSeries<CategoryData, String>(
              enableTooltip: true,
              dataSource: data,
              xValueMapper: (CategoryData data, _) => data.label,
              yValueMapper: (CategoryData data, _) => data.total,
              name: "Category")
        ]);
  }

  Widget getYearOverview(List<ReceiptHolder> receipts) {
    return StatsCard(
        "Annual overview", "Expense overview", getMonthChart(receipts));
  }

  Widget getWeeklyOverview(List<ReceiptHolder> receipts) {
    return StatsCard(
        "Weekly overview", "Expenses overview", getWeeklyChart(receipts));
  }

  Widget getCategoryOverview(List<ReceiptHolder> receipts) {
    return StatsCard(
        "Category overview", "Expenses overview", getCategoryChart(receipts));
  }

  @override
  Widget get view => Material(
      child: Scaffold(
          key: globalKey,
          backgroundColor: Colors.white,
          appBar: NeumorphicAppBar(
            title: Text("Analytics"),
          ),
          body: ControlledWidgetBuilder<StatsController>(
              builder: (context, controller) {
            return StreamBuilder<List<ReceiptHolder>>(
                stream: controller.receipts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }

                  final receipts = snapshot.data ?? [];
                  List<Widget> widgets = [
                    getYearOverview(receipts),
                    getWeeklyOverview(receipts),
                    getCategoryOverview(receipts)
                  ];

                  return Swiper(
                    index: 0,
                    itemBuilder: (BuildContext context, int index) {
                      return widgets[index];
                    },
                    itemCount: widgets.length,
                    scrollDirection: Axis.vertical,
                    pagination:
                        SwiperPagination(builder: SwiperPagination.dots),
                  );
                });
          })));
}

class CategoryData {
  final String label;
  final double total;

  CategoryData(this.label, this.total);
}
