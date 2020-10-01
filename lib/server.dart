library server;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'util/color.dart';
import 'util/input.dart';

class ServerForm extends StatefulWidget {
  @override
  _ServerFormState createState() => _ServerFormState();
}

class _ServerFormState extends State<ServerForm> {
  final textController = TextEditingController();
  var ipv4 = "";

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: TextField(
                  controller: textController,
                  onChanged: (val) => ipv4 = val,
                  inputFormatters: [
                    DecimalTextInputFormatter(decimalRange: 19)
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide:
                          BorderSide(color: HexColor.fromHex("#BB86FC")),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide:
                          BorderSide(color: HexColor.fromHex("#BB86FC")),
                    ),
                    labelText: "Server IP",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide:
                          new BorderSide(color: HexColor.fromHex("#BB86FC")),
                    ),
                  ))),
        ));
  }
}
