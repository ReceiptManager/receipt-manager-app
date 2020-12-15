import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:receipt_manager/painter/curved_painter.dart';

class DashboardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Colors.white,
        body: Container(
            child: Column(
          children: [
            Stack(
              children: [
                CustomPaint(
                  child: Container(
                    height: 250.0,
                  ),
                  painter: CurvePainter(),
                ),
                Padding(
                    padding: EdgeInsets.all(60),
                    child: Column(
                      children: [
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Dashboard ",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Text("statistics",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white))
                          ],
                        )),
                      ],
                    )),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 32),
                  child: Container())
            )
          ],
        )));
  }
}
