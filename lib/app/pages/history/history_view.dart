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

import 'dart:core';

import 'package:animated_stack/animated_stack.dart' as stacked;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:receipt_manager/app/pages/history/history_controller.dart';
import 'package:receipt_manager/app/widgets/icon/icon_tile.dart';
import 'package:receipt_manager/app/widgets/slideable/slidable_widget.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';
import 'package:receipt_manager/data/storage/scheme/holder_table.dart';
import 'package:receipt_manager/generated/l10n.dart';

class HistoryPage extends View {
  @override
  State<StatefulWidget> createState() => HistoryState();
}

class HistoryState extends ViewState<HistoryPage, HistoryController> {
  HistoryState() : super(HistoryController(DataReceiptRepository()));

  Widget receiptVisualisation(BuildContext context) =>
      ControlledWidgetBuilder<HistoryController>(
          builder: (context, controller) {
        return StreamBuilder<List<ReceiptHolder>>(
            stream: controller.getReceipts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }

              if (!snapshot.hasData ||
                  snapshot.data == null ||
                  snapshot.data!.isEmpty) {
                return Column(children: [
                  Center(
                      child: Image.asset(
                    "assets/empty.png",
                    fit: BoxFit.fill,
                  )),
                  Center(child: Text(S.of(context).noReceiptsInserted))
                ]);
              }

              final receipts = snapshot.data ?? [];
              return Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: receipts.length,
                      itemBuilder: (_, index) {
                        final receipt = receipts[index];
                        return FutureBuilder(
                            future: controller.getAssetImage(
                                receipt.store.storeName,
                                receipt.categorie.categoryName),
                            builder: (context, snap) {
                              if (snap.connectionState ==
                                  ConnectionState.done) {
                                return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                            child: SlidableHistoryWidget(
                                                deleteText:
                                                    S.of(context).delete,
                                                deleteMethod: () => controller
                                                    .deleteMethod(receipt),
                                                editText: S.of(context).edit,
                                                editMethod: () =>
                                                    controller.editMethod(
                                                        receipt, context),
                                                image: snap.data as Image,
                                                holder: receipt))));
                              }
                              return Container();
                            });
                      }));
            });
      });

  @override
  Widget get view => stacked.AnimatedStack(
      backgroundColor: Colors.transparent,
      fabBackgroundColor: Colors.red,
      buttonIcon: Icons.filter_list,
      fabIconColor: Colors.white,
      animateButton: true,
      foregroundWidget: Scaffold(
          key: globalKey,
          backgroundColor: Colors.white,
          appBar: NeumorphicAppBar(title: Text(S.of(context).receiptOverview)),
          body: Column(children: [receiptVisualisation(context)])),
      columnWidget: Column(
        children: <Widget>[
          SizedBox(height: 20),
          IconTile(
            width: 60,
            height: 60,
            iconData: Icons.category,
            fun: () {},
          ),
        ],
      ),
      bottomWidget: Container(
        decoration: BoxDecoration(
          color: Color(0xFFEFEFF4),
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        width: 260,
        height: 50,
      ));
}
