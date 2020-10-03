import 'package:flutter/material.dart';
import 'package:frefresh/frefresh.dart';

class HistoryWidget extends StatelessWidget {
  FRefreshController controller;

  HistoryWidget();

  @override
  void initState() {
    controller = FRefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FRefresh(
      /// Setup the controller
      controller: controller,

      /// create Footer area
      footer: LinearProgressIndicator(),

      /// need to setup Footer area height
      footerHeight: 20.0,

      child: new Container(),

      /// This function will be called back after entering the Loading state
      onLoad: () {
        /// End loading state
        controller.finishLoad();
      },
    ));
  }
}
