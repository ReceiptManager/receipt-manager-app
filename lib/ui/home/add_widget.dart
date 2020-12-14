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
import 'package:flutter/rendering.dart';
import 'package:receipt_manager/bloc/moor/db_bloc.dart';
import 'package:receipt_manager/database/receipt_database.dart';
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

  @override
  Widget build(BuildContext context) {
    init();

    return Scaffold(
      backgroundColor: Colors.white,
      body: ReceiptForm(receipt, sendImage, sharedPrefs, _bloc),
    );
  }
}
