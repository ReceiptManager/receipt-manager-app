library server;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:receipt_scanner/main.dart';

class ServerForm extends StatefulWidget {
  @override
  _ServerFormState createState() => _ServerFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _ServerFormState extends State<ServerForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final textController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Server IP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: textController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          /* select the first camera */
          final cameras = await availableCameras();
          final firstCamera = cameras.first;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TakePictureScreen(camera: firstCamera),
            ),
          );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.done_all),
      ),
    );
  }
}
