import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWidget extends StatelessWidget {
  final _textController = TextEditingController();
  String ipv4 = "";

  HomeWidget(SharedPreferences sharedPrefs);

  @override
  void dispose() {
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueAccent,
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white)),
                  child:
                      const Text('New receipt', style: TextStyle(fontSize: 20)),
                  color: Colors.white,
                  textColor: Colors.blueAccent,
                  elevation: 5,
                ))));
  }
}
