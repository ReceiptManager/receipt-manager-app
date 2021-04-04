import 'package:flutter/material.dart';

class SimpleTextfieldWidget extends StatelessWidget {
  final Icon icon;
  final String hintText;
  final String helperText;
  final String labelText;
  final Function validator;
  final TextEditingController controller;

  SimpleTextfieldWidget(
      {@required this.controller,
      @required this.hintText,
      @required this.helperText,
      @required this.labelText,
      @required this.icon,
      @required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: TextStyle(color: Colors.black),
        decoration: new InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[100]),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey[100])),
          hintText: hintText,
          labelText: labelText,
          helperText: helperText,
          prefixIcon: icon,
          prefixText: ' ',
        ),
        controller: controller,
        validator: (value) => validator(value));
  }
}
