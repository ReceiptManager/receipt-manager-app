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
import 'package:receipt_manager/app/widgets/padding/padding_widget.dart';
import 'package:receipt_manager/app/widgets/slideable/slidable_widget.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';
import 'package:receipt_manager/data/storage/scheme/holder_table.dart';

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
                  Center(child: Text("No receipts inserted."))
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
                            // Initialize FlutterFire:
                            future: getAssetImage(receipt.store.storeName,
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
                                                deleteText: "Delete",
                                                deleteMethod: () => controller
                                                    .deleteMethod(receipt),
                                                editText: "Edit",
                                                editMethod: () =>
                                                    controller.editMethod(
                                                        receipt, context),
                                                image: snap.data as Image,
                                                holder: receipt))));
                              }
                              // Otherwise, show something whilst waiting for initialization to complete
                              return Container();
                            });
                      }));
            });
      });

  Future<Image?> imageExists(String path) async {
    try {
      final bundle = DefaultAssetBundle.of(context);
      await bundle.load(path);
    } catch (e) {
      return null;
    }

    return Image.asset(
      path,
      fit: BoxFit.fill,
    );
  }

  Future<Image?> getAssetImage(String storeName, String categoryName) async {
    String storeNamePath =
        "assets/" + storeName.split(" ")[0].trim().toLowerCase();

    List<String> extensions = [".png", ".jpeg", ".jpg"];
    for (var ext in extensions) {
      final String path = storeNamePath + ext;
      Image? image = await imageExists(path);
      if (image != null) return image;
    }

    return await imageExists("assets/fallback.png");
  }

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
          appBar: NeumorphicAppBar(title: Text("Receipt Overview")),
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
