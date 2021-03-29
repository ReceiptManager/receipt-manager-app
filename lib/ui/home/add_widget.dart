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
import 'package:flutter/rendering.dart';
import 'package:receipt_manager/db/bloc/moor/db_bloc.dart';
import 'package:receipt_manager/db/receipt_database.dart';
import 'package:receipt_manager/ui/home/receipt_form.dart';

// ignore: must_be_immutable
class HomeWidget extends StatelessWidget {
  final sharedPrefs;
  final DbBloc _bloc;
  final _textController = TextEditingController();

  ScrollController scrollController;
  ReceiptsCompanion receipt;

  bool sendImage;
  bool scrollVisible = true;

  HomeWidget(this.receipt, this.sendImage, this.sharedPrefs, this._bloc);

  void init() {
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    scrollVisible = value;
  }

  void dispose() {
    _textController.dispose();
  }

  Widget buildBody() {
    return Container(
      color: Colors.white,
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.white)),
                child: Column(children: [Icon(Icons.camera_enhance_outlined)]),
                color: Colors.white,
                textColor: Colors.white,
                elevation: 5,
              ))),
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    init();

    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: ReceiptForm(receipt, sendImage, sharedPrefs, _bloc),
    );
  }
}
