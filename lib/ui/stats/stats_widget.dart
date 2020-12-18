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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipt_manager/bloc/moor/db_bloc.dart';
import 'package:receipt_manager/bloc/moor/db_state.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/ui/stats/categories_screen.dart';
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
          return SingleChildScrollView(
              child: Column(children: <Widget>[
            WeeklyOverviewScreen(receipts),
            CategoryOverviewScreen(receipts)
          ]));
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
