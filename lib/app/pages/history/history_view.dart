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
import 'package:receipt_manager/app/widgets/slideable/slidable_widet.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';
import 'package:receipt_manager/data/storage/receipt_database.dart';
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
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              final receipts = snapshot.data ?? [];

              return Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: receipts.length,
                      itemBuilder: (_, index) {
                        final receipt = receipts[index].receipt;
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                    child: SlidableHistoryWidget(
                                        deleteText: "Delete",
                                        deleteMethod:
                                            controller.deleteMethod(receipt),
                                        editText: "Edit",
                                        editMethod:
                                            controller.editMethod(receipt),
                                        image: Image.asset(
                                          "assets/lidl.png",
                                          fit: BoxFit.fill,
                                        ),
                                        receipt: receipt))));
                      }));
            });
      });

  Image? imageExists(String path) {
    Image image;
    try {
      image = Image.asset(
        path,
        fit: BoxFit.fill,
      );
    } catch (_) {
      return null;
    }

    return image;
  }

  Image getAssetImage(String storeName, String categoryName) {
    String storeNamePath =
        "assets/" + storeName.split(" ")[0].trim().toLowerCase();

    List<String> extentions = [".png", "jpeg", "jpg"];

    for (var ext in extentions) {
      final String path = storeNamePath + ext;
      Image? image = imageExists(path);
      if (image != null) return image;
    }

    String categoryPath =
        "assets/" + categoryName.split(" ")[0].trim().toLowerCase();
    for (var ext in extentions) {
      final String path = categoryPath + ext;
      Image? image = imageExists(path);
      if (image != null) return image;
    }

    return imageExists("assets/fallback.png")!;
  }

  Widget historyWidget() {
    List<Receipt> receipts = [];

    receipts.add(Receipt(
        total: 39.90, date: DateTime.now(), storeName: "Kaufland", id: 1));

    receipts.add(Receipt(
        total: 195.44, date: DateTime.now(), storeName: "Apotheke", id: 1));

    receipts.add(
        Receipt(total: 5.44, date: DateTime.now(), storeName: "Lidl", id: 1));

    receipts.add(
        Receipt(total: 65.44, date: DateTime.now(), storeName: "Netto", id: 1));

    receipts.add(
        Receipt(total: 15.44, date: DateTime.now(), storeName: "Edeka", id: 1));

    receipts.add(
        Receipt(total: 15.44, date: DateTime.now(), storeName: "Edeka", id: 1));

    receipts.add(
        Receipt(total: 15.44, date: DateTime.now(), storeName: "df", id: 1));

    receipts.add(
        Receipt(total: 15.44, date: DateTime.now(), storeName: "Edeka", id: 1));

    return ControlledWidgetBuilder<HistoryController>(
        builder: (context, controller) {
      return Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: receipts.length,
              itemBuilder: (_, index) {
                final receipt = receipts[index];
                return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                            child: SlidableHistoryWidget(
                                deleteText: "Delete",
                                deleteMethod: controller.deleteMethod(receipt),
                                editText: "Edit",
                                editMethod: controller.editMethod(receipt),
                                image: getAssetImage(receipt.storeName, ""),
                                receipt: receipts[index]))));
              }));
    });
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
          appBar: NeumorphicAppBar(title: Text("Receipt overview")),
          body: Column(children: [historyWidget()])),
      columnWidget: Column(
        children: <Widget>[
          SizedBox(height: 20),
          IconTile(
            width: 60,
            height: 60,
            iconData: Icons.insert_drive_file_outlined,
            fun: () {},
          ),
          SizedBox(height: 20),
          IconTile(
            width: 60,
            height: 60,
            iconData: Icons.camera_alt,
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
