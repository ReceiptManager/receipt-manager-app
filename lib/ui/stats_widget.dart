import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipt_parser/bloc/moor/db_bloc.dart';
import 'package:receipt_parser/bloc/moor/db_state.dart';
import 'package:receipt_parser/database/receipt_database.dart';
import 'package:receipt_parser/factory/padding_factory.dart';
import 'package:receipt_parser/generated/l10n.dart';
import 'package:receipt_parser/theme/color/color.dart';

class StatsWidget extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  final DbBloc _bloc;

  StatsWidget(this._bloc);

  @override
  State<StatefulWidget> createState() => StatsWidgetState(_bloc);
}

class StatsWidgetState extends State<StatsWidget> {
  final Color barBackgroundColor = Colors.white; //const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);
  final DbBloc _bloc;

  // store expenses
  List<double> expenses = [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00];

  int touchedIndex;

  StatsWidgetState(this._bloc);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _bloc,
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
          final receipt = state.receipt;
          return _buildList(receipt);
        }

        return Container(
            color: Colors.white,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
                  BoxShadow(offset: Offset(0, 5), blurRadius: 10)
                ]));
      },
    );
  }

  SingleChildScrollView _buildList(r) {
    generateData(r);

    return SingleChildScrollView(
        child: Column(children: <Widget>[
      PaddingFactory.create(AspectRatio(
        aspectRatio: 0.8,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: LightColor.brighter,
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
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      S.of(context).overviewExpenses,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            ],
          ),
        ),
      )),
      PaddingFactory.create(AspectRatio(
        aspectRatio: 0.8,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: LightColor.brighter,
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
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      S.of(context).overviewExpenses,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            ],
          ),
        ),
      )),
    ]));
  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  void generateData(List<Receipt> r) {
    final date = DateTime.now();
    expenses = [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00];
    final startDate = getDate(date.subtract(Duration(days: date.weekday - 1)));

    for (Receipt receipt in r) {
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
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.purple,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    double max =
    expenses.reduce((current, next) => current > next ? current : next);

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.purple] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: max + log(max) / log(2) * 10,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, expenses[0], isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, expenses[1], isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, expenses[2], isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, expenses[3], isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, expenses[4], isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, expenses[5], isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, expenses[6], isTouched: i == touchedIndex);
          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.white,
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
                  TextStyle(color: Colors.purple));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
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

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
  }
}
