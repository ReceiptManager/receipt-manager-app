import 'dart:async';
import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:receipt_manager/factory/padding_factory.dart';
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
