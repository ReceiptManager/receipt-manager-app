import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:receipt_parser/converter/color_converter.dart';
import 'package:receipt_parser/ui/settings/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO toast message in settings_widget.dart
class SettingsWidget extends StatelessWidget {
  final _textController = TextEditingController();
  String ipv4 = "";
  final SharedPreferences sharedPreferences;

  SettingsWidget(this.sharedPreferences);

  void dispose() {
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (sharedPreferences.getString("ipv4") != null) {
      ipv4 = sharedPreferences.getString("ipv4");
      _textController.value = TextEditingValue(
        text: ipv4,
        selection: TextSelection.fromPosition(
          TextPosition(offset: ipv4.length),
        ),
      );
    }

    bool value = true;
    return SettingsScreen();
  }

  sendServerAlert(BuildContext _context) {
    showDialog(
        context: _context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset(
                "assets/robot.gif",
                fit: BoxFit.fill,
              ),
              title: Text(
                'No server responding',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              entryAnimation: EntryAnimation.BOTTOM_RIGHT,
              description: Text(
                'No server is responding on this ip address. Please check if the server is running.',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              onCancelButtonPressed: () {
                Navigator.of(_context).pop();
              },
              onOkButtonPressed: () {
                Navigator.of(_context).pop();
              },
            ));
  }

  serverTextfield() {
    return new TextFormField(
      controller: _textController,
      style: TextStyle(color: Colors.black),
      onChanged: (value) {
        ipv4 = value;
      },
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor.fromHex("#232F34")),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor.fromHex("#232F34")),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: HexColor.fromHex("#232F34"))),
        hintText: 'Server ip',
        labelText: 'Server ip address',
        helperText: "Set the image server ip.",
        prefixIcon: const Icon(
          Icons.network_wifi,
          color: Colors.black,
        ),
        prefixText: ' ',
      ),
    );
  }
}
