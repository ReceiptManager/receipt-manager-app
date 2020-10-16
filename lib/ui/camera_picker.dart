import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:receipt_parser/converter/color_converter.dart';
import 'package:receipt_parser/network/network_client.dart';
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

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

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
        backgroundColor: HexColor.fromHex("#232F34"),
        child: Icon(
          Icons.camera_alt,
        ),
        foregroundColor: HexColor.fromHex("#F9AA33"),
        onPressed: () async {
          await _initializeControllerFuture;

          final path = join(
            (await getTemporaryDirectory()).path,
            'receipt_${DateTime.now()}.png',
          );

          // Take an picture with the best resolution
          await _controller.takePicture(path);

          // Get current ip which is given by the user
          SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
          String ip = sharedPrefs.get("ipv4");

          // parse server response and fill form
          await NetworkClient.sendImage(File(path), ip, context, key);
        },
      ),
    );
  }
}

final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final SharedPreferences sharedPrefs;

  const DisplayPictureScreen({Key key, this.imagePath, this.sharedPrefs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: AppBar(title: Text('Receipt')),
        body: Container(
          color: HexColor.fromHex("#232F34"),
          padding: EdgeInsets.all(32),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(32.0),
                          child: Image.file(
                            File(imagePath),
                            fit: BoxFit.fill,
                            height: 450,
                          )))),
              Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.done,
                    color: Colors.blueAccent,
                  ),
                ),
              )
            ],
          ),
        ));
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
                'No server ip set',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              entryAnimation: EntryAnimation.BOTTOM_RIGHT,
              description: Text(
                'No image server ip is defined. Please set a server ip in the settings',
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

  handshakeExceptionAlert(BuildContext _context) {
    showDialog(
        context: _context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset(
                "assets/robot.gif",
                fit: BoxFit.fill,
              ),
              title: Text(
                'Invalid server certificate',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              entryAnimation: EntryAnimation.BOTTOM_RIGHT,
              description: Text(
                'Certificate verification failed. Please import your server certificate first.',
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

  socketExceptionAlert(BuildContext _context) {
    showDialog(
        context: _context,
        builder: (_) =>
            AssetGiffyDialog(
              image: Image.asset(
                "assets/robot.gif",
                fit: BoxFit.fill,
              ),
              title: Text(
                'Cannot connect to the image server',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              entryAnimation: EntryAnimation.BOTTOM_RIGHT,
              description: Text(
                'The connection to the image server is refused. Please check if the server is running.',
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
}
