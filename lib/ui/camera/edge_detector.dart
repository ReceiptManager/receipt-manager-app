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

import 'package:camera/camera.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:receipt_manager/ui/camera/display_image.dart';

class EdgeDetector extends StatefulWidget {
  @override
  _EdgeDetectorState createState() => new _EdgeDetectorState();
}

class _EdgeDetectorState extends State<EdgeDetector> {
   void getImagePath() async {
    String imagePath;
    try {
      imagePath = await EdgeDetection.detectEdge;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayPictureScreen(imagePath: imagePath),
          ));
    } on PlatformException {
      imagePath = 'Failed to get cropped image path.';
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    getImagePath();
    return Container();
  }
}