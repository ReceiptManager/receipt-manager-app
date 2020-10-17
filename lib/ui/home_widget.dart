import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:receipt_parser/bloc/moor/db_bloc.dart';
import 'package:receipt_parser/database/receipt_database.dart';
import 'package:receipt_parser/ui/receipt_form.dart';

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
      color: Colors.grey,
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.white)),
                child: Column(children: [Icon(Icons.camera)]),
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
      body: ReceiptForm(receipt, sendImage, sharedPrefs, _bloc),
    );
  }
}
