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
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:simple_edge_detection/edge_detection.dart';

import 'edge_detection_shape/edge_detection_shape.dart';

class ImagePreview extends StatefulWidget {
  ImagePreview({required this.imagePath, required this.edgeDetectionResult});

  final String imagePath;
  final EdgeDetectionResult? edgeDetectionResult;

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  GlobalKey imageWidgetKey = GlobalKey();

  @override
  Widget build(BuildContext mainContext) {
    return Center(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(child: Text('Loading ...')),
          Image.file(File(widget.imagePath),
              fit: BoxFit.contain, key: imageWidgetKey),
          FutureBuilder<ui.Image>(
              future: loadUiImage(widget.imagePath),
              builder:
                  (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                return _getEdgePaint(snapshot, context);
              }),
        ],
      ),
    );
  }

  Widget _getEdgePaint(
      AsyncSnapshot<ui.Image> imageSnapshot, BuildContext context) {
    if (imageSnapshot.connectionState == ConnectionState.waiting)
      return Container();

    if (imageSnapshot.hasError) return Text('Error: ${imageSnapshot.error}');
    final keyContext = imageWidgetKey.currentContext;

    if (keyContext == null) {
      return Container();
    }

    final box = keyContext.findRenderObject() as RenderBox;

    return EdgeDetectionShape(
      originalImageSize: Size(imageSnapshot.data!.width.toDouble(),
          imageSnapshot.data!.height.toDouble()),
      renderedImageSize: Size(box.size.width, box.size.height),
      edgeDetectionResult: widget.edgeDetectionResult,
    );
  }

  Future<ui.Image> loadUiImage(String imageAssetPath) async {
    final Uint8List data = await File(imageAssetPath).readAsBytes();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image image) {
      return completer.complete(image);
    });
    return completer.future;
  }
}
