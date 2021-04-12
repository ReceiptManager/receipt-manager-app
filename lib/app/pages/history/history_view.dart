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
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:receipt_manager/app/pages/history/history_controller.dart';
import 'package:receipt_manager/app/widgets/padding/padding_widget.dart';
import 'package:receipt_manager/app/widgets/slideable/slidable_widet.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';

class HistoryPage extends View {
  @override
  State<StatefulWidget> createState() => HistoryState();
}

class HistoryState extends ViewState<HistoryPage, HistoryController> {
  HistoryState() : super(HistoryController(DataReceiptRepository()));

  Widget weeklyOverview(BuildContext context) =>
      ControlledWidgetBuilder<HistoryController>(
          builder: (context, controller) {
        if (controller.receipts.length == 0) return Container();

        return Container(
            child: Align(
                alignment: Alignment.centerRight,
                child: PaddingWidget(
                    widget: Text(controller.getWeeklyOverview,
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 20,
                            color: Colors.black)))));
      });

  Widget receiptVisualisation(BuildContext context) =>
      ControlledWidgetBuilder<HistoryController>(
          builder: (context, controller) {
        return AnimationLimiter(child: Expanded(
          child: DraggableScrollableSheet(builder:
              (BuildContext context, ScrollController scrollController) {
            return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: controller.receipts.length,
                itemBuilder: (_, index) {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                              child: SlidableHistoryWidget(
                                  deleteText: "Delete",
                                  deleteMethod: controller.deleteMethod,
                                  editText: "Edit",
                                  editMethod: controller.editMethod,
                                  imagePath: "assets/lidl.png",
                                  receipt: controller.receipts[index]))));
                });
          }),
        ));
      });

  @override
  Widget get view => Scaffold(
        key: globalKey,
        backgroundColor: Color(0xFFEFEFF4),
        appBar: NeumorphicAppBar(
          title: Text("Receipt overview"),
        ),
        body: Column(
          children: <Widget>[
            weeklyOverview(context),
            receiptVisualisation(context)
          ],
        ),
      );
}
