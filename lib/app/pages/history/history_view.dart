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
import 'package:receipt_manager/app/pages/history/history_controller.dart';
import 'package:receipt_manager/app/widgets/banner_widget.dart';

class HistoryPage extends View {
  @override
  State<StatefulWidget> createState() => HistoryState();
}

class HistoryState extends ViewState<HistoryPage, HistoryController> {
  HistoryState() : super(HistoryController());

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: Column(
          children: <Widget>[
            Center(
              child: ControlledWidgetBuilder<HistoryController>(
                  builder: (context, controller) {
                return BannerWidget(
                  text: "Receipt overview",
                );
              }),
            ),
            ControlledWidgetBuilder<HistoryController>(
                builder: (context, controller) {
              return Container(width: 0.0, height: 0.0);
            }),
          ],
        ),
      );
}
