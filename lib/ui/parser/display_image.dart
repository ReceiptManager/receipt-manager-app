/*
 * Copyright (c) 2020 - 2021 : William Todt
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/network/network_client.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DisplayPictureScreenState(imagePath);
}

class DisplayPictureScreenState extends State<DisplayPictureScreen> {
  final String imagePath;
  final GlobalKey<ScaffoldState> key2 = GlobalKey<ScaffoldState>();
  Color _acceptButtonColor = Colors.green;
  Color _declineButtonColor = Colors.red;
  double _progress = 0.0;
  ProgressDialog pr;

  bool _isButtonDisabled;

  DisplayPictureScreenState(this.imagePath);

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = false;
  }

  @override
  Widget build(BuildContext context) {
    final RoundedLoadingButtonController _btnController =
        new RoundedLoadingButtonController();

    return Scaffold(
        appBar: AppBar(title: Text(S.of(context).receipt)),
        key: key2,
        body: Container(
            color: Colors.black,
            height: double.infinity,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Image.file(File(imagePath), fit: BoxFit.scaleDown),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                            bottom: 30,
                          ),
                          child: IgnorePointer(
                              ignoring: _isButtonDisabled,
                              child: RoundedLoadingButton(
                                  width: 60,
                                  height: 60,
                                  child: Icon(Icons.clear, color: Colors.white),
                                  animateOnTap: true,
                                  color: _declineButtonColor,
                                  controller: _btnController,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }))),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 30,
                        ),
                        child: IgnorePointer(
                            ignoring: _isButtonDisabled,
                            child: RoundedLoadingButton(
                                width: 60,
                                height: 60,
                                child: Icon(Icons.done, color: Colors.white),
                                animateOnTap: true,
                                color: _acceptButtonColor,
                                controller: _btnController,
                                onPressed: () async {
                                  setState(() {
                                    _isButtonDisabled = true;
                                    _declineButtonColor = Colors.grey;
                                  });
                                  SharedPreferences sharedPrefs =
                                      await SharedPreferences.getInstance();

                                  String ip = sharedPrefs.get("ipv4");
                                  String token = sharedPrefs.get("api_token");

                                  bool debugOutput =
                                      sharedPrefs.get("enable_debug_output");
                                  bool grayscale = sharedPrefs.get("grayscale");
                                  bool gaussian = sharedPrefs.get("gaussian");
                                  bool legacyParser =
                                      sharedPrefs.get("legacyParser");
                                  bool rotate = sharedPrefs.get("rotate");

                                  await NetworkClient.sendImage(
                                      File(imagePath),
                                      ip,
                                      token,
                                      debugOutput,
                                      grayscale,
                                      gaussian,
                                      legacyParser,
                                      rotate,
                                      context,
                                      key2);
                                  _progress = _progress + 80.0;
                                })),
                      ),
                    ])
              ],
            )));
  }
}
