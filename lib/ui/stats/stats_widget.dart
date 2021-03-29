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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:receipt_manager/db/bloc/moor/db_bloc.dart';
import 'package:receipt_manager/db/bloc/moor/db_state.dart';
import 'package:receipt_manager/db/receipt_database.dart';
import 'package:receipt_manager/factory/banner_factory.dart';
import 'package:receipt_manager/factory/padding_factory.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/ui/stats/category.dart';
import 'package:receipt_manager/ui/stats/category_overview.dart';
import 'package:receipt_manager/ui/stats/chart_data_month.dart';
import 'package:receipt_manager/ui/stats/monthly_overview.dart';
import 'package:receipt_manager/ui/stats/weekly_chart_data.dart';
import 'package:receipt_manager/ui/stats/weekly_overview.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsWidget extends StatefulWidget {
  final DbBloc _bloc;

  StatsWidget(this._bloc);

  @override
  State<StatefulWidget> createState() => StatsWidgetState(_bloc);
}

class StatsWidgetState extends State<StatsWidget> {
  final DbBloc _bloc;

  int touchIndexWeekly;

  StatsWidgetState(this._bloc);

  TooltipBehavior _tooltipBehavior;
  TooltipBehavior _tooltipBehavior2;
  TooltipBehavior _tooltipBehavior3;

  @override
  void initState() {
    super.initState();

    _tooltipBehavior = TooltipBehavior(enable: true);
    _tooltipBehavior2 = TooltipBehavior(enable: true);
    _tooltipBehavior3 = TooltipBehavior(enable: true);
  }

  Widget getCategoryChart(List<Receipt> receipts) {
    CategoryOverview overview = CategoryOverview(receipts);
    List<CategoryData> data = overview.getData();

    return SfCircularChart(
        legend: Legend(isVisible: true),
        tooltipBehavior: _tooltipBehavior3,
        series: <CircularSeries>[
          PieSeries<CategoryData, String>(
              enableTooltip: true,
              dataSource: data,
              xValueMapper: (CategoryData data, _) => data.label,
              yValueMapper: (CategoryData data, _) => data.total,
              name: S.of(context).expensesByCategory)
        ]);
  }

  String dateString(DateTime date) {
    return DateFormat.E().format(date);
  }

  Widget getMonthChart(List<Receipt> receipts) {
    MonthlyOverview overview = MonthlyOverview(receipts);
    List<ReceiptMonthData> data = overview.getData();

    int year = DateTime.now().year;
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          LineSeries<ReceiptMonthData, String>(
              name: S.of(context).overviewExpenses,
              color: Colors.red,
              dataSource: data,
              xValueMapper: (ReceiptMonthData data, _) =>
                  DateFormat.MMM().format((DateTime.utc(year, data.month, 0))),
              yValueMapper: (ReceiptMonthData data, _) => data.total)
        ]);
  }

  Widget getWeeklyChart(List<Receipt> receipts, BuildContext context) {
    WeeklyOverview overview = WeeklyOverview(receipts, context);
    List<WeeklyChartData> data = overview.getData();

    int year = DateTime.now().year;
    int month = DateTime.now().month;

    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        tooltipBehavior: _tooltipBehavior2,
        series: <ChartSeries>[
          ColumnSeries<WeeklyChartData, String>(
              color: Colors.red,
              name: S.of(context).overview,
              dataSource: data,
              xValueMapper: (WeeklyChartData data, _) =>
                  DateFormat.E().format((DateTime.utc(year, month, data.day))),
              yValueMapper: (WeeklyChartData data, _) => data.total,
              enableTooltip: true,
              width: 0.75)
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorState) {
          return Center(
            child: Text(S.of(context).receiptLoadFailed),
          );
        }
        if (state is LoadedState) {
          final receipts = state.receipts;

          return SingleChildScrollView(
            child: Column(
              children: [
                BannerFactory.get(BANNER_MODES.OVERVIEW_EXPENSES, context),
                PaddingFactory.create(AspectRatio(
                    aspectRatio: 1.25,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
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
                                  S.of(context).overviewExpenses,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  S.of(context).yearOverview,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: getMonthChart(receipts),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))),
                PaddingFactory.create(AspectRatio(
                    aspectRatio: 1.25,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
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
                                  S.of(context).overviewExpenses,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  S.of(context).overview,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  child: getWeeklyChart(receipts, context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))),
                (receipts == null || receipts.length == 0)
                    ? Container()
                    : PaddingFactory.create(AspectRatio(
                        aspectRatio: 1.25,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          color: Colors.white,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      S.of(context).expensesByCategory,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      S.of(context).yearOverview,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Expanded(
                                      child: getCategoryChart(receipts),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ))),
              ],
            ),
          );
        }

        return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
              BoxShadow(offset: Offset(0, 5), blurRadius: 10)
            ]));
      },
    );
  }
}
