/*
 * Copyright (c) 2020 - William Todt
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:exif/exif.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:receipt_manager/factory/padding_factory.dart';
import 'package:receipt_manager/network/network_client.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  final SharedPreferences sharedPrefs;

  const TakePictureScreen({
    @required this.sharedPrefs,
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _controller = CameraController(widget.camera, ResolutionPreset.ultraHigh);

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(title: Text('Take a receipt')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "imagePicker",
        child: Icon(
          Icons.camera_alt,
        ),
        onPressed: () async {
          await _initializeControllerFuture;

          final path = join(
            (await getTemporaryDirectory()).path,
            'receipt_${DateTime.now()}.png',
          );

          // Take an picture with the best resolution
          await _controller.takePicture(path);
          // await FlutterExifRotation.rotateAndSaveImage(path: path);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ));
        },
      ),
    );
  }
}

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

  Future<File> fixExifRotation(String imagePath) async {
    final originalFile = File(imagePath);
    List<int> imageBytes = await originalFile.readAsBytes();

    final originalImage = img.decodeImage(imageBytes);
    final height = originalImage.height;
    final width = originalImage.width;

    if (height >= width) {
      return originalFile;
    }

    final exifData = await readExifFromBytes(imageBytes);
    img.Image fixedImage;

    if (height < width) {
      if (exifData['Image Orientation'].printable.contains('Horizontal')) {
        fixedImage = img.copyRotate(originalImage, 90);
      } else if (exifData['Image Orientation'].printable.contains('180')) {
        fixedImage = img.copyRotate(originalImage, -90);
      } else if (exifData['Image Orientation'].printable.contains('CCW')) {
        fixedImage = img.copyRotate(originalImage, 180);
      } else {
        fixedImage = img.copyRotate(originalImage, 0);
      }
    }

    final fixedFile =
        await originalFile.writeAsBytes(img.encodeJpg(fixedImage));
    return fixedFile;
  }

  @override
  Widget build(BuildContext context) {
    final RoundedLoadingButtonController _btnController =
        new RoundedLoadingButtonController();

    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      key: key2,
      body: Column(
        children: [
          Center(
              child: PaddingFactory.create(Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Image.file(File(imagePath))))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PaddingFactory.create(Center(
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
                          })))),
              PaddingFactory.create(Center(
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

                            //await fixExifRotation(imagePath);
                            await NetworkClient.sendImage(
                                File(imagePath), ip, context, key2);
                            _progress = _progress + 80.0;
                          })))),
            ],
          )
        ],
      ),
    );
  }
}
