import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:receipt_parser/converter/color_converter.dart';
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

    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: new Theme(
                    data: new ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                    ),
                    child: serverTextfield())),
            new Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton(
                        onPressed: () async {
                          final ipv4_regex =
                              "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\$";

                          RegExp ipRegex = new RegExp(ipv4_regex,
                              caseSensitive: false, multiLine: false);

                          if (ipv4.isEmpty || !ipRegex.hasMatch(ipv4)) {
                            showDialog(
                                context: context,
                                builder: (_) => AssetGiffyDialog(
                                      image: Image.asset(
                                        "assets/robot.gif",
                                        fit: BoxFit.fill,
                                      ),
                                      title: Text(
                                        'Invalid server ip',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      entryAnimation:
                                          EntryAnimation.BOTTOM_RIGHT,
                                      description: Text(
                                        'The given submitted server ip appear invalid. Please try again.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(),
                                      ),
                                      onCancelButtonPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      onOkButtonPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ));
                            return;
                          }

                          sharedPreferences.setString("ipv4", ipv4);
                          Scaffold.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                              content: Text("Server ip is set."),
                              backgroundColor: Colors.green,
                            ));
                        },
                        child: Icon(Icons.done_all),
                        backgroundColor: HexColor.fromHex("#232F34"),
                        foregroundColor: HexColor.fromHex("#F9AA33"))))
          ],
        ),
      ),
    );
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
