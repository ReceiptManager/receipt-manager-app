import 'package:flutter/material.dart';
import 'package:receipt_manager/painter/curved_painter.dart';
import 'package:receipt_manager/util/dimensions.dart';

class BannerFactory {
  static get(String content, BuildContext context) {
    List<String> contentArr = content.split(" ");
    String firstText = "";
    String secondText = "";

    if (contentArr.length == 2) {
      secondText = content.split(" ")[1];
    }

    firstText = content.split(" ")[0] + " ";
    firstText = firstText == null ? "" : firstText;
    secondText = secondText == null ? "" : secondText;

    return Stack(
      children: [
        CustomPaint(
          child: Container(
            height: DimensionsCalculator.getBannerHeight(context),
          ),
          painter: CurvePainter(),
        ),
        Align(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(
                    top: DimensionsCalculator.getBannerHeight(context) / 3.5),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(firstText,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Text(secondText,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white))
                        ],
                      ),
                    ),
                  ],
                ))),
      ],
    );
  }
}
