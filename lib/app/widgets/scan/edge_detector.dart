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
import 'dart:isolate';

import 'package:simple_edge_detection/edge_detection.dart';

class EdgeDetector {
  static Future<void> startEdgeDetectionIsolate(
      EdgeDetectionInput edgeDetectionInput) async {
    EdgeDetectionResult result =
        await EdgeDetection.detectEdges(edgeDetectionInput.inputPath);
    edgeDetectionInput.sendPort.send(result);
  }

  static Future<void> processImageIsolate(
      ProcessImageInput processImageInput) async {
    EdgeDetection.processImage(
        processImageInput.inputPath, processImageInput.edgeDetectionResult);
    processImageInput.sendPort.send(true);
  }

  Future<EdgeDetectionResult> detectEdges(String filePath) async {
    final port = ReceivePort();

    _spawnIsolate<EdgeDetectionInput>(startEdgeDetectionIsolate,
        EdgeDetectionInput(inputPath: filePath, sendPort: port.sendPort), port);

    return await _subscribeToPort<EdgeDetectionResult>(port);
  }

  Future<bool> processImage(
      String filePath, EdgeDetectionResult edgeDetectionResult) async {
    final port = ReceivePort();

    _spawnIsolate<ProcessImageInput>(
        processImageIsolate,
        ProcessImageInput(
            inputPath: filePath,
            edgeDetectionResult: edgeDetectionResult,
            sendPort: port.sendPort),
        port);

    return await _subscribeToPort<bool>(port);
  }

  void _spawnIsolate<T>(Function(T) function, dynamic input, ReceivePort port) {
    Isolate.spawn<T>(function, input,
        onError: port.sendPort, onExit: port.sendPort);
  }

  Future<T> _subscribeToPort<T>(ReceivePort port) async {
    StreamSubscription sub;

    var completer = new Completer<T>();

    sub = port.listen((result) async {
      completer.complete(await result);
    });

    await sub.cancel();
    return completer.future;
  }
}

class EdgeDetectionInput {
  EdgeDetectionInput({required this.inputPath, required this.sendPort});

  String inputPath;
  SendPort sendPort;
}

class ProcessImageInput {
  ProcessImageInput(
      {required this.inputPath,
      required this.edgeDetectionResult,
      required this.sendPort});

  String inputPath;
  EdgeDetectionResult edgeDetectionResult;
  SendPort sendPort;
}
