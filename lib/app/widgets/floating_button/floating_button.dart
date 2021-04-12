import 'package:flutter/material.dart';
import 'package:receipt_manager/app/pages/home/home_controller.dart';

class FloatingButton extends StatelessWidget {
  final String text;
  final HomeController controller;

  FloatingButton({required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return new ButtonTheme(
        buttonColor: Colors.black,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: StadiumBorder(), shadowColor: Colors.black),
            onPressed: controller.submit,
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            )));
  }
}
