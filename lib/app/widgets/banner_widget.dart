import 'package:flutter/material.dart';
import 'package:receipt_manager/app/helper/curved_painter.dart';

class BannerWidget extends StatelessWidget {
  final String text;

  BannerWidget({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          child: Container(
            height: 200,
          ),
          painter: CurvePainter(),
        ),
        Align(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(text,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ))),
      ],
    );
  }
}
