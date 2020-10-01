import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsWidget extends StatelessWidget {
  final _textController = TextEditingController();
  String ipv4 = "";
  final SharedPreferences sharedPreferences;

  SettingsWidget(this.sharedPreferences);

  @override
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
      color: Colors.blueAccent,
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
                    child: new TextField(
                      controller: _textController,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        ipv4 = value;
                      },
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white)),
                        hintText: 'Server IP',
                        helperText: 'Submit the receipt parser server adresse.',
                        labelText: 'Server IP',
                        prefixIcon: const Icon(
                          Icons.network_wifi,
                          color: Colors.white,
                        ),
                        prefixText: ' ',
                      ),
                    ))),
            new Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: new FloatingActionButton(
                        onPressed: () async {
                          final IPV4_REGEX =
                              "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\$";

                          RegExp ipRegex = new RegExp(IPV4_REGEX,
                              caseSensitive: false, multiLine: false);

                          if (ipv4.isEmpty || !ipRegex.hasMatch(ipv4)) {
                            Widget okButton = FlatButton(
                              child: Text("Ok"),
                              textColor: Colors.red,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );

                            AlertDialog alert = AlertDialog(
                              title: Text("IP invalid"),
                              content: Text(
                                  "The given ip address appears invalid. Please check the ip again."),
                              actions: [okButton],
                            );

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );

                            return;
                          }
                          Widget no = FlatButton(
                            child: Text("No"),
                            textColor: Colors.grey,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          );

                          Widget yes = FlatButton(
                            child: Text("yes"),
                            textColor: Colors.red,
                            onPressed: () async {
                              this.sharedPreferences.setString("ipv4", ipv4);
                              Navigator.of(context).pop();
                            },
                          );

                          AlertDialog alert = AlertDialog(
                            title: Text("Validate the server ip"),
                            content:
                                Text("Is the following ip correct:" + ipv4),
                            actions: [no, yes],
                          );

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                        child: Icon(Icons.done_all),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueAccent))),
          ],
        ),
      ),
    );
  }
}
