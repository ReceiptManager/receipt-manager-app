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
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:receipt_manager/app/widgets/scan/cropping_preview.dart';
import 'package:simple_edge_detection/edge_detection.dart';

import 'camera_view.dart';
import 'edge_detector.dart';
import 'image_view.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  late CameraController controller;
  late List<CameraDescription> cameras;
  String? imagePath;
  String? croppedImagePath;
  EdgeDetectionResult? edgeDetectionResult;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _getMainWidget(),
          _getBottomBar(),
        ],
      ),
    );
  }

  Widget _getMainWidget() {
    if (croppedImagePath != null) {
      return ImageView(imagePath: croppedImagePath!);
    }

    if (imagePath == null && edgeDetectionResult == null) {
      return CameraView(controller: controller);
    }

    return ImagePreview(
      imagePath: imagePath!,
      edgeDetectionResult: edgeDetectionResult,
    );
  }

  Future<void> _initializeController() async {
    cameras = await availableCameras();

    if (cameras.length == 0) {
      log('No cameras detected');
      return;
    }

    controller = CameraController(cameras[0], ResolutionPreset.veryHigh,
        enableAudio: false);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _getButtonRow() {
    if (imagePath != null) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            if (croppedImagePath == null) {
              _processImage(imagePath!, edgeDetectionResult!);
            }

            setState(() {
              imagePath = null;
              edgeDetectionResult = null;
              croppedImagePath = null;
            });
          },
        ),
      );
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      FloatingActionButton(
        foregroundColor: Colors.white,
        child: Icon(Icons.camera_alt),
        onPressed: onTakePictureButtonPressed,
      ),
      SizedBox(width: 16),
      FloatingActionButton(
        foregroundColor: Colors.white,
        child: Icon(Icons.image),
        onPressed: _onGalleryButtonPressed,
      ),
    ]);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<String?> takePicture() async {
    if (!controller.value.isInitialized) {
      log('Error: select a camera first.');
      return null;
    }

    final Directory extDir = await getTemporaryDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      return null;
    }
    XFile file;

    try {
      file = await controller.takePicture();
    } on CameraException catch (e) {
      log(e.toString());
      return null;
    }
    return file.path;
  }

  Future _detectEdges(String filePath) async {
    if (!mounted || filePath == null) {
      return;
    }

    setState(() {
      imagePath = filePath;
    });

    EdgeDetectionResult result = await EdgeDetector().detectEdges(filePath);

    setState(() {
      edgeDetectionResult = result;
    });
  }

  Future _processImage(
      String filePath, EdgeDetectionResult edgeDetectionResult) async {
    if (!mounted || filePath == null) {
      return;
    }

    bool result =
        await EdgeDetector().processImage(filePath, edgeDetectionResult);

    if (result == false) {
      return;
    }

    setState(() {
      imageCache!.clearLiveImages();
      imageCache!.clear();
      croppedImagePath = imagePath;
    });
  }

  void onTakePictureButtonPressed() async {
    String? filePath = await takePicture();

    log('Picture saved to $filePath');

    await _detectEdges(filePath!);
  }

  void _onGalleryButtonPressed() async {
    ImagePicker picker = ImagePicker();
    PickedFile? pickedFile = await picker.getImage(source: ImageSource.gallery);
    final filePath = pickedFile!.path;

    log('Picture saved to $filePath');

    _detectEdges(filePath);
  }

  Padding _getBottomBar() {
    return Padding(
        padding: EdgeInsets.only(bottom: 32),
        child:
            Align(alignment: Alignment.bottomCenter, child: _getButtonRow()));
  }
}
