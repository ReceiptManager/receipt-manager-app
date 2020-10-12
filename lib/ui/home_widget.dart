import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:receipt_parser/database/receipt_database.dart';
import 'package:receipt_parser/ui/receipt_form.dart';

class HomeWidget extends StatelessWidget {
  final _textController = TextEditingController();
  ScrollController scrollController;
  bool scrollVisible = true;
  Receipt receipt;
  bool sendImage;

  HomeWidget(this.receipt, this.sendImage);

  @override
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

  @override
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
    return Scaffold(
      body: ReceiptForm(receipt, sendImage),
    );
  }
}
