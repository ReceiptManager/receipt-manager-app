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
import 'package:receipt_manager/bloc/moor/db_bloc.dart';
import 'package:receipt_manager/bloc/moor/db_state.dart';
import 'package:receipt_manager/factory/banner_factory.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/ui/stats/weekly_screen.dart';

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
          final receipts = state.receipt;
          return Column(children: [
            BannerFactory.get(BANNER_MODES.OVERVIEW_EXPENSES, context),
            SingleChildScrollView(
                child: Column(children: <Widget>[
              WeeklyOverviewScreen(receipts),
              //     CategoryOverviewScreen(receipts)
            ]))
          ]);
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
