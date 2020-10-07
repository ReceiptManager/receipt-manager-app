import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

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

    HttpOverrides.global = new MyHttpOverrides();

    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a receipt')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              'receipt_${DateTime.now()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final SharedPreferences sharedPrefs;

  const DisplayPictureScreen({Key key, this.imagePath, this.sharedPrefs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Receipt')),
        body: Container(
          color: Colors.blueAccent,
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
                  onPressed: () {
                    uploadImage(this.imagePath, context);
                  },
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

  handshake_exception_msg(BuildContext _context) {
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

  socket_exception_msg(BuildContext _context) {
    showDialog(
        context: _context,
        builder: (_) => AssetGiffyDialog(
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

  Future<void> uploadImage(String imagePath, BuildContext context) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String ip = sharedPrefs.getString("ipv4");
    if (ip == null || ip.isEmpty) {
      sendServerAlert(context);
      print("No ip is set.");
    }

    print("Try to upload image at image at: " + ip);
    var im = File(imagePath);
    var stream = new http.ByteStream(DelegatingStream.typed(im.openRead()));
    var length = await im.length();

    var uri = Uri.parse("https://" + ip + ":8721/api/upload");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(im.path));

    request.files.add(multipartFile);
    try {
      var response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    } catch (e) {
      print("[ERROR]" + e.toString());
      if (e == SocketException) {
        socket_exception_msg(context);
      } else if (e  == HandshakeException) {
        handshake_exception_msg(context);
      }
    }
  }
}
